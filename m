Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 May 2012 21:32:47 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:33337 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903714Ab2ENTcm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 May 2012 21:32:42 +0200
Received: by dadm1 with SMTP id m1so7175056dad.36
        for <linux-mips@linux-mips.org>; Mon, 14 May 2012 12:32:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent
         :x-gm-message-state;
        bh=KEfJzXeiIAv7zIWYV/g+Z25sulSahArpy+NyDRlmuT4=;
        b=gNlSzlQAqOt+wlzknPKoIMX7QnaFLVi/orGXvVYbZAQWUclzBz8qDHJrmf+E+ESZB1
         kbPOGcKMGIpSiMtsXkCTacFjieWv8eF/N6Qb/p45aEFdW/8torrH8ZxKDVS5xb5OcLwg
         N0PFSUxhxkZbzf2EHRtNFhxl7JDqsnMpzUR9NRk+56PfEn/3VlnhCT9a0NzcRiAnmRCq
         S5EMldyJUeqsavoRGlW+WcZ1P3dYBbUCjPdDqsGsMvdvrkoklCD0OejbdTqVKeqWuM2y
         mVl15Uycigsrc2zUiDnFiWtXtUr2Kv4Q3Az1Im3Xf3XoLvCGKuBkVYxiHy78NKakRMHC
         luXg==
Received: by 10.68.223.138 with SMTP id qu10mr1818199pbc.124.1337023955483;
        Mon, 14 May 2012 12:32:35 -0700 (PDT)
Received: from localhost (c-67-168-183-230.hsd1.wa.comcast.net. [67.168.183.230])
        by mx.google.com with ESMTPS id pl7sm23077612pbb.59.2012.05.14.12.32.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 14 May 2012 12:32:34 -0700 (PDT)
Date:   Mon, 14 May 2012 12:32:32 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     John Crispin <blogic@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org
Subject: Re: [RESEND PATCH V2 10/17] SERIAL: MIPS: lantiq: implement OF
 support
Message-ID: <20120514193232.GA5741@kroah.com>
References: <1337017363-14424-1-git-send-email-blogic@openwrt.org>
 <1337017363-14424-10-git-send-email-blogic@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1337017363-14424-10-git-send-email-blogic@openwrt.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Gm-Message-State: ALoCoQlCEHIKbl+tLMmMUlLUcXEivAABaFIBzNdxHgBcvc+3m1ueCEaVNL7p+Npsw8YoGaEqSzRI
X-archive-position: 33312
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Mon, May 14, 2012 at 07:42:36PM +0200, John Crispin wrote:
> Add devicetree and handling for our new clkdev clocks. The patch is rather
> straightforward. .of_match_table is set and the 3 irqs are now loaded from the
> devicetree.
> 
> This series converts the lantiq target to clkdev amongst other things. The
> driver needs to handle two clocks now. The fpi bus clock used to derive the
> divider and the clock gate needed on some socs to make the secondary port work.
> 
> Signed-off-by: John Crispin <blogic@openwrt.org>
> Cc: Alan Cox <alan@linux.intel.com>
> Cc: linux-serial@vger.kernel.org
> ---
> This patch is part of a series moving the mips/lantiq target to OF and clkdev
> support. The patch, once Acked, should go upstream via Ralf's MIPS tree.

Fine with me as well, if you need it:
  Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
