Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Sep 2015 23:25:39 +0200 (CEST)
Received: from mail-wi0-f180.google.com ([209.85.212.180]:35550 "EHLO
        mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013409AbbIBVZhZEolk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Sep 2015 23:25:37 +0200
Received: by wicge5 with SMTP id ge5so54279971wic.0;
        Wed, 02 Sep 2015 14:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=kayW8qaDB+9WsZ1P4VAjR7UTzSEiruh42mK4Q982O14=;
        b=drAVw7yjgEAEmYddLeuoOQ7ZbT9+9EePfeGA0OKkq1fDWLFY39Y3b8oHyB81IZ/e4r
         8g0c/KIYvXAaYht9riTPXiamIYokIj3xmCQNJinDhwPHHBK29z2ZxKYUSN3nNAFbWeES
         1Ct8zMwja7g1zlq0Z0gUU6PVcZ8M3A905izqKF1IildbxWyUNxwpN3LVILbH4ZHdhqNV
         eQroNvCcQ+IWJFJ5RYbC5bTHQGxQtcy9nra07CHb8+82Qk1LU9UqUFbqe3aVB3BNMN4f
         edqEyNABvVifzQO1t/RwKn7HYH2hWB2N53yl9knSNjYwaEpnJ4+n7xd8bzHzH/BB8/4s
         LIZQ==
X-Received: by 10.194.5.103 with SMTP id r7mr41791611wjr.47.1441229132182;
        Wed, 02 Sep 2015 14:25:32 -0700 (PDT)
Received: from [172.28.172.4] ([46.188.253.53])
        by smtp.googlemail.com with ESMTPSA id a19sm34271679wjr.27.2015.09.02.14.25.29
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Sep 2015 14:25:31 -0700 (PDT)
Subject: Re: initrd support broken in mips kernel 4.2
To:     ext Tony Wu <tung7970@gmail.com>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>
References: <20150831122702-tung7970@googlemail.com>
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
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
Message-ID: <55E76948.2000101@gmail.com>
Date:   Wed, 2 Sep 2015 23:25:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <20150831122702-tung7970@googlemail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <alexander.sverdlin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49087
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexander.sverdlin@gmail.com
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

Hello Tony,

On 31/08/15 06:50, ext Tony Wu wrote:
> Commit a6335fa11 (MIPS: bootmem: Don't use memory holes for page bitmap) 
> crashes kernel with a initramfs unpacking error when initrd is enabled. 
> 
> ---- error message ----
> Unpacking initramfs...
> Initramfs unpacking failed: junk in compressed archive
> BUG: Bad page state in process swapper  pfn:00261
> page:81004c20 count:0 mapcount:-127 mapping:  (null) index:0x2
> flags: 0x0()
> page dumped because: nonzero mapcount
> CPU: 0 PID: 1 Comm: swapper Not tainted 4.2.0+ #1782
> -----------------------
> 
> The modified logic in bootmem_init does not guarantee mapstart to be placed 
> after initrd_end. mapstart is set to the maximum of reserved_end and
> start. In case initrd_end is greater than reserved_end, mapstart is placed
> before initrd_end, and causes initramfs unpacking error.

Indeed, seems that there are two problems with the patch. First, "<=" is wrong
in the condition. This will fail if initrd and next zone are separated (in
boot_mem_map), but have not gap in between. Second, without gap, initrd and PFN
area could be combined together by add_memory_region(), so seems that we need
to restore max() that was there before a6335fa11.

> ----- bootmem_init ---
>                 if (end <= reserved_end)
>                         continue;
> +#ifdef CONFIG_BLK_DEV_INITRD
> +               /* mapstart should be after initrd_end */
> +               if (initrd_end && end <= (unsigned long)PFN_UP(__pa(initrd_end)))
> +                       continue;
> +#endif
>                 if (start >= mapstart)
>                         continue;
>                 mapstart = max(reserved_end, start);
> -----------------------

Could you please test the following patch? It fixes the case with gap between
initrd and first usable zone and restores the effect of f9a7febd for the case
when initrd and the next zone are combined together.

--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -339,7 +339,7 @@ static void __init bootmem_init(void)
 			continue;
 #ifdef CONFIG_BLK_DEV_INITRD
 		/* mapstart should be after initrd_end */
-		if (initrd_end && end <= (unsigned long)PFN_UP(__pa(initrd_end)))
+		if (initrd_end && end < (unsigned long)PFN_UP(__pa(initrd_end)))
 			continue;
 #endif
 		if (start >= mapstart)
@@ -371,6 +371,14 @@ static void __init bootmem_init(void)
 		max_low_pfn = PFN_DOWN(HIGHMEM_START);
 	}

+#ifdef CONFIG_BLK_DEV_INITRD
+	/*
+	 * mapstart should be after initrd_end
+	 */
+	if (initrd_end)
+		mapstart = max(mapstart, (unsigned long)PFN_UP(__pa(initrd_end)));
+#endif
+
 	/*
 	 * Initialize the boot-time allocator with low memory only.
 	 */
