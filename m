Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 May 2013 18:58:22 +0200 (CEST)
Received: from ch1ehsobe003.messaging.microsoft.com ([216.32.181.183]:2121
        "EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835074Ab3EWQ6QeClIE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 May 2013 18:58:16 +0200
Received: from mail9-ch1-R.bigfish.com (10.43.68.228) by
 CH1EHSOBE012.bigfish.com (10.43.70.62) with Microsoft SMTP Server id
 14.1.225.23; Thu, 23 May 2013 16:58:10 +0000
Received: from mail9-ch1 (localhost [127.0.0.1])        by mail9-ch1-R.bigfish.com
 (Postfix) with ESMTP id 0CA16340264;   Thu, 23 May 2013 16:58:10 +0000 (UTC)
X-Forefront-Antispam-Report: CIP:157.56.238.53;KIP:(null);UIP:(null);IPV:NLI;H:BY2PRD0712HT004.namprd07.prod.outlook.com;RD:none;EFVD:NLI
X-SpamScore: -4
X-BigFish: PS-4(zzbb2dI98dI9371I1432Izz1f42h1ee6h1de0h1fdah1202h1e76h1d1ah1d2ah1fc6hzz8275bhz2dh2a8h668h839h947hd25he5bhf0ah1288h12a5h12a9h12bdh137ah13b6h1441h14ddh1504h1537h153bh162dh1631h1758h1765h18e1h190ch1946h19b4h19c3h19ceh1ad9h1b0ah1d0ch1d2eh1d3fh1155h)
Received: from mail9-ch1 (localhost.localdomain [127.0.0.1]) by mail9-ch1
 (MessageSwitch) id 1369328289162101_10098; Thu, 23 May 2013 16:58:09 +0000
 (UTC)
Received: from CH1EHSMHS027.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.242])        by mail9-ch1.bigfish.com (Postfix) with ESMTP id 20F76240114;
        Thu, 23 May 2013 16:58:09 +0000 (UTC)
Received: from BY2PRD0712HT004.namprd07.prod.outlook.com (157.56.238.53) by
 CH1EHSMHS027.bigfish.com (10.43.70.27) with Microsoft SMTP Server (TLS) id
 14.1.225.23; Thu, 23 May 2013 16:58:04 +0000
Received: from dl.caveonetworks.com (64.2.3.195) by pod51018.outlook.com
 (10.255.246.37) with Microsoft SMTP Server (TLS) id 14.16.293.5; Thu, 23 May
 2013 16:58:02 +0000
Message-ID: <519E4A98.7020903@caviumnetworks.com>
Date:   Thu, 23 May 2013 09:58:00 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130311 Thunderbird/17.0.4
MIME-Version: 1.0
To:     Gleb Natapov <gleb@redhat.com>
CC:     David Daney <ddaney.cavm@gmail.com>, <linux-mips@linux-mips.org>,
        <ralf@linux-mips.org>, <kvm@vger.kernel.org>,
        Sanjay Lal <sanjayl@kymasys.com>,
        <linux-kernel@vger.kernel.org>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH v5 0/6] mips/kvm: Fix ABI for compatibility with 64-bit
 guests.
References: <1369248236-27237-1-git-send-email-ddaney.cavm@gmail.com> <20130523102834.GN4725@redhat.com>
In-Reply-To: <20130523102834.GN4725@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.195]
X-OriginatorOrg: caviumnetworks.com
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36564
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
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

On 05/23/2013 03:28 AM, Gleb Natapov wrote:
> On Wed, May 22, 2013 at 11:43:50AM -0700, David Daney wrote:
>> From: David Daney <david.daney@cavium.com>
>>
> Please regenerate against master. arch/mips/include/asm/kvm.h does not
> exists any more.

New patch sent.  I gather from this message, that you want to merge this 
particular set via your tree instead of Ralf's MIPS tree.  That's fine 
with me.  However, we were hoping to have these ABI fixing patches 
pushed to Linus before 3.10 releases, so that there don't exist kernel 
versions with the defective ABI.

Future patch sets may affect core MIPS architecture files, and therefore 
may not be so amenable to merging via the KVM tree.  We will have to 
figure out how to handle that.

David Daney
