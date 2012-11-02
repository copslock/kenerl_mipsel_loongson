Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Nov 2012 18:00:21 +0100 (CET)
Received: from kymasys.com ([64.62.140.43]:45127 "HELO kymasys.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S6825659Ab2KBRAUg3tUe convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Nov 2012 18:00:20 +0100
Received: from ::ffff:173.33.185.184 ([173.33.185.184]) by kymasys.com for <linux-mips@linux-mips.org>; Fri, 2 Nov 2012 10:00:12 -0700
Subject: Re: [PATCH 07/20] KVM/MIPS32: Dynamic binary translation of select privileged instructions.
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type:   text/plain; charset=US-ASCII
From:   Sanjay Lal <sanjayl@kymasys.com>
In-Reply-To: <5092942C.4080402@redhat.com>
Date:   Fri, 2 Nov 2012 13:00:11 -0400
Cc:     kvm@vger.kernel.org, linux-mips@linux-mips.org
Content-Transfer-Encoding: 7BIT
Message-Id: <9CDFDB77-71D3-462A-9724-C7FA0E73B190@kymasys.com>
References: <3E678B37-B4C1-409F-A1CB-A7CC83B2D874@kymasys.com> <5092942C.4080402@redhat.com>
To:     Avi Kivity <avi@redhat.com>
X-Mailer: Apple Mail (2.1283)
X-archive-position: 34858
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
Return-Path: <linux-mips-bounce@linux-mips.org>


On Nov 1, 2012, at 11:24 AM, Avi Kivity wrote:

> On 10/31/2012 05:19 PM, Sanjay Lal wrote:
>> Currently, the following instructions are translated:
>> - CACHE (indexed)
>> - CACHE (va based): translated to a synci, overkill on D-CACHE operations, but still much faster than a trap.
>> - mfc0/mtc0: the virtual COP0 registers for the guest are implemented as 2-D array
>>  [COP#][SEL] and this is mapped into the guest kernel address space @ VA 0x0.
>>  mfc0/mtc0 operations are transformed to load/stores.
>> 
> 
> Seems to be more of binary patching, yes?  Binary translation usually
> involves hiding the translated code so the guest is not able to detect
> that it is patched.

Now that you mention it, I think binary patching would be more applicable.  If the "self-aware" guest ever compared the code it would realize that it has changed.

Regards
Sanjay
