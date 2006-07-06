Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Jul 2006 14:07:34 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.184]:32010 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S3466326AbWGFNHY (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 6 Jul 2006 14:07:24 +0100
Received: by nf-out-0910.google.com with SMTP id a27so79996nfc
        for <linux-mips@linux-mips.org>; Thu, 06 Jul 2006 06:07:24 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=CLDP9vO0jhrpmySENUWO5UK5vUuT/MlvQRje0LeI5IgzYGvK5Qeiv8KuLyFhgfNe1S6CKYM95N/YqTeop2ww5V+Wr4+XKdjwDUJ+UcsN86SBtHAtYHaSPehBFr4Ng1C0EFYq4aRtuDWGkFaiyb7V2lkZlWSKyBRM8U2gAxTRz5c=
Received: by 10.48.80.3 with SMTP id d3mr449227nfb;
        Thu, 06 Jul 2006 06:07:23 -0700 (PDT)
Received: from ?192.168.0.24? ( [194.3.162.233])
        by mx.gmail.com with ESMTP id l22sm6713706nfc.2006.07.06.06.07.22;
        Thu, 06 Jul 2006 06:07:23 -0700 (PDT)
Message-ID: <44AD0C2B.7060204@innova-card.com>
Date:	Thu, 06 Jul 2006 15:12:11 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	vagabon.xyz@gmail.com, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: [PATCH] do not count pages in holes with sparsemem
References: <20060705.221354.74751389.anemo@mba.ocn.ne.jp>	<44ABC59C.6070607@innova-card.com> <20060705.231737.59032119.anemo@mba.ocn.ne.jp>
In-Reply-To: <20060705.231737.59032119.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11920
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> On Wed, 05 Jul 2006 15:58:52 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
>> BTW why using __pa(OFFSET) ? isn't it going to yield always into 0 ?
>> At least on MIPS, it's defined as
>>
>> #define __pa(x)	((unsigned long) (x) - PAGE_OFFSET)
>>
>> why not using ARCH_PFN_OFFSET instead ?
> 
> Indeed.  I copied the code from free_area_init().  I think 0 is enough
> for MIPS.  Patch revised.  Thank you for comments.
> 
> 

Ok thinking more about it, some platforms may have physical memory
that doesn't start at 0. MIPS doesn't support such platform though it
should be fairly easy. In that case __pa should be defined as:

	#define __pa(x)	((unsigned long) (x) - PAGE_OFFSET + PFN_PHYS(ARCH_PFN_OFFSET))

and use in your patch:

	free_area_init_node(0, NODE_DATA(0), zones_size, ARCH_PFN_OFFSET, zholes_size);

So I would recommend to use ARCH_PFN_OFFSET.

		Franck
