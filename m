Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Aug 2015 06:51:07 +0200 (CEST)
Received: from mail-pa0-f51.google.com ([209.85.220.51]:33457 "EHLO
        mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006764AbbHaEvGTTiZe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 31 Aug 2015 06:51:06 +0200
Received: by padhy3 with SMTP id hy3so21207377pad.0;
        Sun, 30 Aug 2015 21:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=JiqjfPaeJ8H2B92E8tQYNa57e2DM/v4pHxg8sIYbOkU=;
        b=lvlKDvgWdM/f2EUvQGSvcMZutTpoCDJZ/Pw+tihGGRtkzgXHYA0uv+rQbleisl447w
         kEFQXtI0hjEqebogg4ZqccUwSVg6eDiKJKidPUeVOeBq0qEry7QfWwnd6FQ+xWI1bwt9
         0hqVeivEjZSbjpq98czjgeXlREJrN/vHTdqn2SDTdIP6UZpOWABpX+1sqM6DkMhPiMPD
         Iy8TTw4UD0x5LcOgtXkwIZbLOql9YIOKXoXEccIX6gRu2TnmLf6mLERAK8f3LOBalZvr
         tNxhNK3i1tPttd6YRepOFZxsPZKvWpNZK7XLbNZksXglnLdx1jDtbTg63+etJQZYxgbr
         +nyw==
X-Received: by 10.69.26.161 with SMTP id iz1mr34669114pbd.17.1440996660030;
        Sun, 30 Aug 2015 21:51:00 -0700 (PDT)
Received: from yggdrasil.local (42-73-176-21.EMOME-IP.hinet.net. [42.73.176.21])
        by smtp.gmail.com with ESMTPSA id j5sm12880799pdi.7.2015.08.30.21.50.56
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Aug 2015 21:50:59 -0700 (PDT)
Date:   Mon, 31 Aug 2015 12:50:52 +0800
From:   Tony Wu <tung7970@gmail.com>
To:     Alexander Sverdlin <alexander.sverdlin@nokia.com>
Cc:     linux-mips@linux-mips.org, David Daney <david.daney@cavium.com>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Huacai Chen <chenhc@lemote.com>,
        Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        Joe Perches <joe@perches.com>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Yusuf Khan <yusuf.khan@nokia.com>,
        Michael Kreuzer <michael.kreuzer@nokia.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: initrd support broken in mips kernel 4.2
Message-ID: <20150831122702-tung7970@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <tung7970@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49071
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tung7970@gmail.com
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

Hello,

Commit a6335fa11 (MIPS: bootmem: Don't use memory holes for page bitmap) 
crashes kernel with a initramfs unpacking error when initrd is enabled. 

---- error message ----
Unpacking initramfs...
Initramfs unpacking failed: junk in compressed archive
BUG: Bad page state in process swapper  pfn:00261
page:81004c20 count:0 mapcount:-127 mapping:  (null) index:0x2
flags: 0x0()
page dumped because: nonzero mapcount
CPU: 0 PID: 1 Comm: swapper Not tainted 4.2.0+ #1782
-----------------------

The modified logic in bootmem_init does not guarantee mapstart to be placed 
after initrd_end. mapstart is set to the maximum of reserved_end and
start. In case initrd_end is greater than reserved_end, mapstart is placed
before initrd_end, and causes initramfs unpacking error.

----- bootmem_init ---
                if (end <= reserved_end)
                        continue;
+#ifdef CONFIG_BLK_DEV_INITRD
+               /* mapstart should be after initrd_end */
+               if (initrd_end && end <= (unsigned long)PFN_UP(__pa(initrd_end)))
+                       continue;
+#endif
                if (start >= mapstart)
                        continue;
                mapstart = max(reserved_end, start);
-----------------------

Thanks,
Tony
