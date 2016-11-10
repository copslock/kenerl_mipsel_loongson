Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Nov 2016 13:38:07 +0100 (CET)
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34630 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992279AbcKJMiAq04wP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 10 Nov 2016 13:38:00 +0100
Received: by mail-wm0-f65.google.com with SMTP id g23so2885558wme.1;
        Thu, 10 Nov 2016 04:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OclXAPE8BiItDLa78XehGf7GFosb9ZhSF8XK6e0UUJg=;
        b=L67a1MjT6uG1L28Mh9hA6PUzw5a90KTG0G4EChYP/xS7cE+VEzOIs7t+axTDLDrRbE
         iaAXD5jm0E9YCEkZEx1o5mcwRAJhhxO2x9NhRvHQE4ILdRWBxfJzr53nM+MvEPdngN4c
         TrZdllzGI+/fIN2vyaFj2t8Nfo4ig9YM1ggr8Ms0yrOWS/Grr6wLpI0qY5PgwMT81Uyf
         k2oszM00AqEVWZ4R/HvZconjgLXpQbhcUlXgcHOGUP6axDRLx8DV+GKlmeucdm507m4K
         pUjoln1olVV0rgoto5F0O9jTnOttWPs71fU67WIxY7WWlXEY55aIxcQ3tTpm7A1watJ9
         2KJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OclXAPE8BiItDLa78XehGf7GFosb9ZhSF8XK6e0UUJg=;
        b=jgQC644QmqcBJBBZnmsaIr8TJwVg1LSrOxay9JtXhNd+6ee4eeV6xu+zfDKXndJPMv
         0nGC5YbsO1TGFHtsAsdD5q3A0ZPR6TWrgDTsADcxvEYzg4cAvrGf8C976jJJ1ws5SPIQ
         DlR+RMmisq097gFe3P+WhsHlC5qTt/yd5SUbWOFzXqMUhGXJ0gyWcGLdu8Z/TuOaaa/D
         JcLPYTzESP7hJcI4U7Rk8f5hgjPibYWChplbez3aJ73cMb79zjFp+m5fABptP8sXWVhn
         u36UuHhul1AB4pAZLXs2uImQr0FLKuFR7RS3+Gbn/HwQcCskkjSnzxHMVKH+ZCK3FMwO
         30VA==
X-Gm-Message-State: ABUngveQZGXYD6c+fV6UUcXNaEPy7Dh6bBlIDee2BJOtP51JeNLZ1Qx3cIvGM4kMFcRIKw==
X-Received: by 10.28.98.130 with SMTP id w124mr5922195wmb.125.1478781475436;
        Thu, 10 Nov 2016 04:37:55 -0800 (PST)
Received: from sudip-tp (82-70-136-246.dsl.in-addr.zen.co.uk. [82.70.136.246])
        by smtp.gmail.com with ESMTPSA id ua15sm5331204wjb.1.2016.11.10.04.37.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Nov 2016 04:37:54 -0800 (PST)
Date:   Thu, 10 Nov 2016 12:37:48 +0000
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        james.hogan@imgtec.com
Subject: Re: [PATCH v2] MIPS: fix duplicate define
Message-ID: <20161110123748.GA1477@sudip-tp>
References: <1478724294-15736-1-git-send-email-sudipm.mukherjee@gmail.com>
 <201611102022.W1caG4gN%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201611102022.W1caG4gN%fengguang.wu@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <sudipm.mukherjee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55772
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sudipm.mukherjee@gmail.com
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

On Thu, Nov 10, 2016 at 08:23:58PM +0800, kbuild test robot wrote:
> Hi Sudip,
> 
> [auto build test ERROR on linus/master]
> [also build test ERROR on v4.9-rc4 next-20161110]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Sudip-Mukherjee/MIPS-fix-duplicate-define/20161110-044738
> config: mips-ip27_defconfig (attached as .config)
> compiler: mips64-linux-gnuabi64-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=mips 
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from arch/mips/include/asm/page.h:194:0,
>                     from arch/mips/vdso/vdso.h:26,
>                     from arch/mips/vdso/gettimeofday.c:11:
>    arch/mips/include/asm/io.h: In function 'phys_to_virt':
> >> arch/mips/include/asm/io.h:138:9: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
>      return (void *)(address + PAGE_OFFSET - PHYS_OFFSET);
>             ^
>    arch/mips/include/asm/io.h: In function 'isa_bus_to_virt':
>    arch/mips/include/asm/io.h:151:9: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
>      return (void *)(address + PAGE_OFFSET);
>             ^
>    cc1: all warnings being treated as errors

I have seen this before submitting and it is not related to the patch I
submitted. My patch fixed one build failure, the build continued and it
again failed in some other error which needs to be fixed also. I will
have a look after this patch is accepted.

Thanks
Sudip
