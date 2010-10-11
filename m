Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Oct 2010 16:47:24 +0200 (CEST)
Received: from mail-qw0-f49.google.com ([209.85.216.49]:61300 "EHLO
        mail-qw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490958Ab0JKOrR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 Oct 2010 16:47:17 +0200
Received: by qwj8 with SMTP id 8so1687278qwj.36
        for <linux-mips@linux-mips.org>; Mon, 11 Oct 2010 07:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:cc:content-type;
        bh=OmHRLOKFUXHKw9ssjWirBxTDeLSL92vjC1yN1PM5kOw=;
        b=TTqD4T0KK9BXxrcatrm5Ed+7BfUesTeg0vVU78nCd9vITmZibQQ2AKwCGF6SKAWWJT
         jq0MXUDImThQKzWid1OcFOFzTBWdZZ5ldbZGBt67VOjNqCOM/NijS9IH7bCJZ6ZCOAJd
         unaRnIxW1aOk5FFe2E9nku3a8EGZwsHe3yVLo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=cPd3GAA/iibUufg/M3IHx977V9t7OL4Ug6xcbn/bgkkElm/DAq5Jd40PWdfjl6uERl
         /zYDN72S/qtQrpyaP3yX86BDDyeqacQIMBPQ58xO/05Kra6shRZ2mGPtEAsdXbi/oL+T
         FpaYp10wGj+gDtIou3iscX1cmGqWR3cHD9G94=
MIME-Version: 1.0
Received: by 10.224.95.142 with SMTP id d14mr4565525qan.379.1286808419192;
 Mon, 11 Oct 2010 07:46:59 -0700 (PDT)
Received: by 10.229.221.146 with HTTP; Mon, 11 Oct 2010 07:46:59 -0700 (PDT)
Date:   Mon, 11 Oct 2010 22:46:59 +0800
Message-ID: <AANLkTi=ST1v55skkQbfsNQsmiBpOARwAnTxCpptsTdtB@mail.gmail.com>
Subject: Question about kimage_alloc_page in kexec.c, bug?
From:   "wilbur.chan" <wilbur512@gmail.com>
To:     linux-kernel <Linux-kernel@zh-kernel.org>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <wilbur512@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28036
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wilbur512@gmail.com
Precedence: bulk
X-list: linux-mips

Hi all !

I have a question on kimage_alloc_page:


page = kimage_alloc_pages(gfp_mask, 0);
...

/* If the page cannot be used file it away */
if (page_to_pfn(page) > (KEXEC_SOURCE_MEMORY_LIMIT >> PAGE_SHIFT)) {
	list_add(&page->lru, &image->unuseable_pages);
	continue;
}


If  a page frame is right at physical address 0x20000000 ,  then when calling

machine_kexec , the following code:

*ptr = (unsigned long) phys_to_virt(*ptr);

will generate an virtual address of 0xa0000000 = 0x20000000+0x80000000 , which

results in physical address 0.



should it be like this?  :

--- kexec.c     2010-08-27 07:47:12.000000000 +0800
+++ kexec.changed.c     2010-10-11 22:04:08.000000000 +0800
@@ -723,7 +723,7 @@
                if (!page)
                        return NULL;
                /* If the page cannot be used file it away */
-               if (page_to_pfn(page) >
+               if (page_to_pfn(page) >=
                                (KEXEC_SOURCE_MEMORY_LIMIT >> PAGE_SHIFT)) {
                        list_add(&page->lru, &image->unuseable_pages);
                        continue;


Thank you
