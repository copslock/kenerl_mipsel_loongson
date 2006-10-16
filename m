Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Oct 2006 09:48:38 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.191]:60040 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20038795AbWJPIsh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 16 Oct 2006 09:48:37 +0100
Received: by nf-out-0910.google.com with SMTP id l23so2410429nfc
        for <linux-mips@linux-mips.org>; Mon, 16 Oct 2006 01:48:36 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=j+ol6Mh2NTDm5MpO3YnLO7zOQ9wzVEQF1PvPlBFHMHfmyWgkLVf/C/NHPlf23e2M/72gzfb0j55VZ7b9E98RYpYivVF0yjwHxbmUmLWyZdUth/v8elxj9ZqM4byjdCzvuL1dN3LbNznFNNk8TjbGrqUhTynAqsIFY1RKO0NNxRE=
Received: by 10.49.43.2 with SMTP id v2mr11712410nfj;
        Mon, 16 Oct 2006 01:48:36 -0700 (PDT)
Received: from ?192.168.0.24? ( [81.252.61.1])
        by mx.google.com with ESMTP id l21sm169666nfc.2006.10.16.01.48.35;
        Mon, 16 Oct 2006 01:48:35 -0700 (PDT)
Message-ID: <45334765.6000805@innova-card.com>
Date:	Mon, 16 Oct 2006 10:48:37 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	vagabon.xyz@gmail.com, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 6/7] setup.c: clean up initrd related code
References: <11607431461469-git-send-email-fbuihuu@gmail.com>	<1160743146503-git-send-email-fbuihuu@gmail.com>	<45333CC1.3090704@innova-card.com> <20061016.171046.55511403.nemoto@toshiba-tops.co.jp>
In-Reply-To: <20061016.171046.55511403.nemoto@toshiba-tops.co.jp>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12959
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> On Mon, 16 Oct 2006 10:03:13 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
>>>  	end = (unsigned long)&_end;
>>>  	tmp = PAGE_ALIGN(end) - sizeof(u32) * 2;
>>>  	if (tmp < end)
>>>  		tmp += PAGE_SIZE;
>>>  
>> Any idea on what is this code for ?
>> It seems that a minimum gap is needed betweend the end of kernel
>> code and initrd but I don't see why...
> 
> Perhaps because current tools put initrd image at that place.
> 
> For example:
> 
> arch/mips/boot/addinitrd.c:92:
> 	loadaddr = ((SWAB(esecs[2].s_vaddr) + SWAB(esecs[2].s_size)
> 			+ MIPS_PAGE_SIZE-1) & ~MIPS_PAGE_MASK) - 8;
> 	if (loadaddr < (SWAB(esecs[2].s_vaddr) + SWAB(esecs[2].s_size)))
> 		loadaddr += MIPS_PAGE_SIZE;
> 	initrd_header[0] = SWAB(0x494E5244);
> 	initrd_header[1] = SWAB(st.st_size);
> 

thanks but it doesn't explain anything either...Anyways what about this
patch on top of the previous one ?

-- >8 --

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 811a8fd..0e61e18 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -177,15 +177,13 @@ static unsigned long __init init_initrd(
 	if (initrd_end > initrd_start)
 		goto sanitize;
 
-	end = (unsigned long)&_end;
-	tmp = PAGE_ALIGN(end) - sizeof(u32) * 2;
-	if (tmp < end)
-		tmp += PAGE_SIZE;
-
+	/*
+	 * FIXME: a good comment would be nice here...
+	 */
+	initrd_header = __va(PAGE_ALIGN(__pa_symbol(&_end) + sizeof(u32) * 2 + 1));
 	initrd_start = 0;
 	initrd_end = 0;
 	end = 0;
-	initrd_header = (u32 *)tmp;
 	if (initrd_header[0] == 0x494E5244) {
 		initrd_start = (unsigned long)&initrd_header[2];
 		initrd_end = initrd_start + initrd_header[1];
