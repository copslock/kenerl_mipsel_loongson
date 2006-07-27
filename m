Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Jul 2006 10:01:42 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.189]:10412 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S8133372AbWG0JB3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 27 Jul 2006 10:01:29 +0100
Received: by nf-out-0910.google.com with SMTP id q29so92478nfc
        for <linux-mips@linux-mips.org>; Thu, 27 Jul 2006 02:01:27 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=KXdXECXv/BUDirNB6IH8QkJ6p6acXvGrgRKoZksJOM4ekOJkJtPtIRh7SGxn3KZ9VGLsMkuxaCuK21c4c8WjFn8xiXCV60d0QlFdo3zaQQh1YfafMiPQLyuDbsYdTLUjmrrT3J54RoLbJC/EKezzQ/vOPiXaG2HmmD138aI9GXE=
Received: by 10.48.240.10 with SMTP id n10mr1546511nfh;
        Thu, 27 Jul 2006 02:01:27 -0700 (PDT)
Received: from ?192.168.0.24? ( [194.3.162.233])
        by mx.gmail.com with ESMTP id p43sm448014nfa.2006.07.27.02.01.26;
        Thu, 27 Jul 2006 02:01:27 -0700 (PDT)
Message-ID: <44C880A9.1070402@innova-card.com>
Date:	Thu, 27 Jul 2006 11:00:25 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	vagabon.xyz@gmail.com, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: [PATCH] do not count pages in holes with sparsemem
References: <44B3625B.7000700@innova-card.com>	<20060711.222458.74752678.anemo@mba.ocn.ne.jp>	<44C77D49.90205@innova-card.com> <20060727.002153.41632148.anemo@mba.ocn.ne.jp>
In-Reply-To: <20060727.002153.41632148.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12089
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> On Wed, 26 Jul 2006 16:33:45 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
>> I don't think that's correct to mark them as "reserved". Basicaly
>> "reserved" means that it belongs to the kernel (code or data), these
>> holes are not and we will end up to have wrong value as you pointed
>> out.
>>
>> Having quick look at sparsemem code, I don't think that it expects
>> to have holes inside a section, do it ? If so you probably have to
>> fix up your section size...
> 
> Yes, for such small holes, sparsemem and flatmem is same.  We can use
> smaller section size to save more memory, but I suppose it will be a
> bit slower.
> 

I'm suprised that sparsemem code doens't check for holes inside
sections. I would feel really more confortable to use sparsemem if a
check like the following patch exists. We could safely use pfn_valid()
in _any_ cases and if holes exist inside sections then the user have
to fix up its section sizes.

what do you think ?

		Franck

-- >8 --

diff --git a/mm/sparse.c b/mm/sparse.c
index 86c52ab..4c29a13 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -119,6 +119,13 @@ void memory_present(int nid, unsigned lo
 {
 	unsigned long pfn;
 
+	if (start & (PAGES_PER_SECTION-1) || end & (PAGES_PER_SECTION-1)) {
+		printk(KERN_ERR "SPARSEMEM: memory area (%lx-%lx) creates a "
+		       "hole inside a section, fix your SECTION_SIZE_BITS "
+		       "value...\n", start, end);
+		BUG();
+	}
+	
 	start &= PAGE_SECTION_MASK;
 	for (pfn = start; pfn < end; pfn += PAGES_PER_SECTION) {
 		unsigned long section = pfn_to_section_nr(pfn);
