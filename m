Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Nov 2008 20:09:11 +0000 (GMT)
Received: from sj-iport-6.cisco.com ([171.71.176.117]:36446 "EHLO
	sj-iport-6.cisco.com") by ftp.linux-mips.org with ESMTP
	id S23144045AbYKDUJH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 4 Nov 2008 20:09:07 +0000
X-IronPort-AV: E=Sophos;i="4.33,544,1220227200"; 
   d="scan'208";a="188543344"
Received: from sj-dkim-1.cisco.com ([171.71.179.21])
  by sj-iport-6.cisco.com with ESMTP; 04 Nov 2008 20:09:00 +0000
Received: from sj-core-4.cisco.com (sj-core-4.cisco.com [171.68.223.138])
	by sj-dkim-1.cisco.com (8.12.11/8.12.11) with ESMTP id mA4K90wq018949;
	Tue, 4 Nov 2008 12:09:00 -0800
Received: from cliff.cisco.com (cliff.cisco.com [171.69.11.141])
	by sj-core-4.cisco.com (8.13.8/8.13.8) with ESMTP id mA4K8xUa009312;
	Tue, 4 Nov 2008 20:08:59 GMT
Received: from [127.0.0.1] ([64.101.20.200]) by cliff.cisco.com (8.6.12/8.6.5) with ESMTP id UAA11570; Tue, 4 Nov 2008 20:08:59 GMT
Message-ID: <4910ABDE.5030007@cisco.com>
Date:	Tue, 04 Nov 2008 12:09:02 -0800
From:	David VomLehn <dvomlehn@cisco.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To:	Lance Richardson <lance604@gmail.com>
CC:	linux-mips@linux-mips.org
Subject: Re: [PATCH 2.6.24][MIPS]Work in progress: fix HIGHMEM-enabled dcache
 flushing on 32-bit processor
References: <ff8dda500811041007u78bbb496m2c65be7d3486e114@mail.gmail.com>
In-Reply-To: <ff8dda500811041007u78bbb496m2c65be7d3486e114@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; l=1900; t=1225829340; x=1226693340;
	c=relaxed/simple; s=sjdkim1004;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=dvomlehn@cisco.com;
	z=From:=20David=20VomLehn=20<dvomlehn@cisco.com>
	|Subject:=20Re=3A=20[PATCH=202.6.24][MIPS]Work=20in=20progr
	ess=3A=20fix=20HIGHMEM-enabled=20dcache=0A=20flushing=20on=2
	032-bit=20processor
	|Sender:=20;
	bh=arYuNllN1NYbhXTVYyrPnbb1ht8Gf9f+5VXXZ0QVUPU=;
	b=JC3wJlwl7Dli+dxO7um1YnE8vUWiZGJpvbtxvqVD8t4I4l4SGuAlBBxG+0
	vTAtxokcB1s9puI/lZjKhEc/2m1ug1F8t5jTOtC7lTOVj+0yhIxViOvCw9G0
	kK7uzPO0sx7iN3GXECRZGSCUY7hRCrGTxYCA+fk6TusHYgn1dB/7k=;
Authentication-Results:	sj-dkim-1; header.From=dvomlehn@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim1004 verified; ); 
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21188
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

Lance Richardson wrote:
> ...I have tracked down the cause of a crash that only
> occurs with SMP enabled, and wondered there might be a better approach than
> the one I took for fixing it.
> 
> The crash scenario involves one CPU having an atomic mapping of type KM_USER0
> in use when the other CPU happens to call r4k_flush_cachee_page(),
> which in turn
> calls r4k_on_each_cpu() for local_r4k_flush_cache_page().  The original CPU is
> interrupted (still with an active KM_USER0 mapping),
> local_r4k_flush_cache_page()
> is called, and in the process another KM_USER0 mapping is attempted (and fails
> in flames.)
> 
> The diffs below (against 2.6.26.1) appear to have eliminated this
> problem - does this
> make sense, and is there a better way?

I think it does make sense.
...
>  static inline void local_r4k_flush_cache_page(void *args)
> @@ -452,6 +453,12 @@
>  	pmd_t *pmdp;
>  	pte_t *ptep;
>  	void *vaddr;
> +        enum km_type kmtype;
> +
> +        if (fcp_args->cpu == smp_processor_id())
> +                kmtype = KM_USER0;
> +        else
> +                kmtype = KM_FLUSH_CACHE_PAGE;

The basis for checking the CPU number is slightly obscure, and caching is hard 
enough to understand as it is. How about always dedicating your new km_type enum 
KM_FLUSH_CACHE_PAGE to cross-processor cache flushing?

First, take the guts of local_r4k_flush_cache_page and move them to a new 
function, common_r4k_flush_cache_page, that takes a void* arg and an enum 
km_type. Change local_r4k_flush_cache_page to call this new function with a 
second argument of KM_USER0.

Next, have r4k_flush_cache_page call a new function which then calls 
common_r4k_flush_cache_page with a second argument of KM_FLUSH_CACHE_PAGE.

This approach may have very slightly better performance and lets you keep the 
size of flush_cache_page_args the same.
