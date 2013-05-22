Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 May 2013 18:33:31 +0200 (CEST)
Received: from kymasys.com ([64.62.140.43]:60809 "HELO kymasys.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S6827470Ab3EVQd0My2d- convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 May 2013 18:33:26 +0200
Received: from ::ffff:75.40.23.192 ([75.40.23.192]) by kymasys.com for <linux-mips@linux-mips.org>; Wed, 22 May 2013 09:33:16 -0700
Subject: Re: [PATCH v4 0/6] mips/kvm: Fix ABI for compatibility with 64-bit guests.
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
From:   Sanjay Lal <sanjayl@kymasys.com>
In-Reply-To: <20130522125453.GN14287@redhat.com>
Date:   Wed, 22 May 2013 09:33:17 -0700
Cc:     David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org,
        ralf@linux-mips.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <88128283-D1AD-4D69-B5B5-0579F346087C@kymasys.com>
References: <1369169695-10444-1-git-send-email-ddaney.cavm@gmail.com> <20130522125453.GN14287@redhat.com>
To:     Gleb Natapov <gleb@redhat.com>
X-Mailer: Apple Mail (2.1283)
Return-Path: <sanjayl@kymasys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36526
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


On May 22, 2013, at 5:54 AM, Gleb Natapov wrote:

> On Tue, May 21, 2013 at 01:54:49PM -0700, David Daney wrote:
>> From: David Daney <david.daney@cavium.com>
>> 
>> The initial patch set implementing MIPS KVM does not handle 64-bit
>> guests or use of the FPU.  This patch set corrects these ABI issues,
>> and does some very minor clean up.
>> 
> Sanjay, is this looks good to you. 
> 
> What userspace MIPS is using for machine emulation? Is there corresponding
> patches to the userspace?

Gleb, I'll post some comments on the patches later in the day.  We use QEMu for the machine emulation. I am in the process of integrating with the new ABI, and will post the QEMU patches shortly.

Regards
Sanjay
