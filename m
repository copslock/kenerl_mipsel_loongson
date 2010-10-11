Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Oct 2010 17:02:15 +0200 (CEST)
Received: from mail-qy0-f170.google.com ([209.85.216.170]:62807 "EHLO
        mail-qy0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491027Ab0JKPCM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 Oct 2010 17:02:12 +0200
Received: by qyk34 with SMTP id 34so3339728qyk.15
        for <linux-mips@linux-mips.org>; Mon, 11 Oct 2010 08:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:cc:content-type;
        bh=OmHRLOKFUXHKw9ssjWirBxTDeLSL92vjC1yN1PM5kOw=;
        b=rxhbj/bqzjrJSmwdNEfvAPO55PLuQtEXsS+J+ZIEXM+sIbMXffZzIZGRXiO5GDgJQp
         5wbj5TXhhegk1LwltJ54+QhBd9AWyCJ5QLH7TLpMJrcQXzaTLqhSDPB8+7AIiK/YjnvI
         SVdeyxwEJ5NH/oFVcFbuycjOV6utmowMdxWCs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=grE9OHQkKu6a/48Km2TqDz32DhXYvDPGVAF8swkAxHpHHkadZyfDXRNcFVhm/lOcME
         G5rCGI+sA2BGB3ShsaT4p+J0Ve2ErV/RN5BXP/oILVO+3q6x0n5/pyQ1qajc4NjC35q5
         Ub60EauPVCT9NMLd0C3lug9O5oNPbT+uBoMw0=
MIME-Version: 1.0
Received: by 10.224.6.213 with SMTP id a21mr4592051qaa.293.1286809326051; Mon,
 11 Oct 2010 08:02:06 -0700 (PDT)
Received: by 10.229.221.146 with HTTP; Mon, 11 Oct 2010 08:02:06 -0700 (PDT)
Date:   Mon, 11 Oct 2010 23:02:06 +0800
Message-ID: <AANLkTikEG7g0oEK5JbNpdzX8NpevfdRYmWBMvzH5Q9jM@mail.gmail.com>
Subject: Question about kimage_alloc_page in kexec.c, bug?
From:   "wilbur.chan" <wilbur512@gmail.com>
To:     Linux MIPS Mailing List <linux-mips@linux-mips.org>
Cc:     kexec@lists.infradead.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <wilbur512@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28037
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
