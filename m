Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 May 2013 18:58:51 +0200 (CEST)
Received: from kymasys.com ([64.62.140.43]:44176 "HELO kymasys.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S6823098Ab3ETQ6ukJHuU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 May 2013 18:58:50 +0200
Received: from ::ffff:75.40.23.192 ([75.40.23.192]) by kymasys.com for <linux-mips@linux-mips.org>; Mon, 20 May 2013 09:58:42 -0700
Subject: Re: [PATCH 00/18] KVM/MIPS32: Support for the new Virtualization ASE (VZ-ASE)
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=iso-8859-1
From:   Sanjay Lal <sanjayl@kymasys.com>
In-Reply-To: <519A4640.6060202@gmail.com>
Date:   Mon, 20 May 2013 09:58:41 -0700
Cc:     kvm@vger.kernel.org, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Gleb Natapov <gleb@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <456B70C6-A896-4B94-B8EF-DE6ED26CE859@kymasys.com>
References: <n> <1368942460-15577-1-git-send-email-sanjayl@kymasys.com> <519A4640.6060202@gmail.com>
To:     David Daney <ddaney.cavm@gmail.com>
X-Mailer: Apple Mail (2.1283)
Return-Path: <sanjayl@kymasys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36484
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sanjayl@kymasys.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips


On May 20, 2013, at 8:50 AM, David Daney wrote:

> On 05/18/2013 10:47 PM, Sanjay Lal wrote:
>> The following patch set adds support for the recently announced virtualization
>> extensions for the MIPS32 architecture and allows running unmodified kernels in
>> Guest Mode.
>> 
>> For more info please refer to :
>> 	MIPS Document #: MD00846
>> 	Volume IV-i: Virtualization Module of the MIPS32 Architecture
>> 
>> which can be accessed @: http://www.mips.com/auth/MD00846-2B-VZMIPS32-AFP-01.03.pdf
>> 
>> The patch is agains Linux-3.10-rc1.
>> 
>> KVM/MIPS now supports 2 modes of operation:
>> 
>> (1) VZ mode: Unmodified kernels running in Guest Mode.  The processor now provides
>>     an almost complete COP0 context in Guest mode. This greatly reduces VM exits.
> 
> Two questions:
> 
> 1) How are you handling not clobbering the Guest K0/K1 registers when a Root exception occurs?  It is not obvious to me from inspecting the code.
> 
> 2) What environment are you using to test this stuff?
> 
> David Daney
> 

(1) Newer versions of the MIPS architecture define scratch registers for just this purpose, but since we have to support standard MIPS32R2 processors, we use the DDataLo Register (CP0 Register 28, Select 3) as a scratch register to save k0 and save k1 @ a known offset from EBASE.

(2) Platforms that we've tested on:

KVM Trap & Emulate
- Malta Board with FPGA based 34K
- Sigma Designs TangoX board with a 24K based 8654 SoC.
- Malta Board with 74K @ 1GHz
- QEMU (as of 1.4.90)
- Imperas M*SDK MIPS32 simulator

KVM MIPS/VZ
- Imperas M*SDK MIPS32 simulator + MIPS/VZ model.

Regards
Sanjay
