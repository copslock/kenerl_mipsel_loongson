Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 Dec 2014 00:23:55 +0100 (CET)
Received: from resqmta-po-11v.sys.comcast.net ([96.114.154.170]:58188 "EHLO
        resqmta-po-11v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009184AbaLZXXxWswgp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 27 Dec 2014 00:23:53 +0100
Received: from resomta-po-12v.sys.comcast.net ([96.114.154.236])
        by resqmta-po-11v.sys.comcast.net with comcast
        id YPPe1p00456HXL001PPlVt; Fri, 26 Dec 2014 23:23:45 +0000
Received: from [192.168.1.13] ([76.100.35.31])
        by resomta-po-12v.sys.comcast.net with comcast
        id YPPj1p00M0gJalY01PPkvE; Fri, 26 Dec 2014 23:23:45 +0000
Message-ID: <549DEDF4.7010405@gentoo.org>
Date:   Fri, 26 Dec 2014 18:23:32 -0500
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Re: [PATCH] arch: mips: fw: arc: file.c:  Remove some unused functions
References: <1419182212-9529-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
In-Reply-To: <1419182212-9529-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1419636225;
        bh=zNruykocVAlIUH3gPFzYw+MGAA7YS+X8Zqv343ZzFPM=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=DQhaQlckhy9nCvbxoemB4mjOIwF+LRR/oCe3FXpFowim2mTZdZYCOxM1ddX+p1frV
         wkbux0yALea/IrO0DzF6PYES5vF1iudAyl87quhsC17Fj9Eeaw0g6xOWNMxwV/JvzI
         zubN9uhhz6KEW2ASE3xCf0cTSeNBbVD3yLXvG03WRxtupLr1ptFv8LwyEM86fhv1G1
         jfBA4su0jeGpqsKVPMbM6A2qS9ZdtsINJRyW/k+bU/XUdeQol/9ZB1jxn5QV3SZ7El
         384F+yR/1aO42r1ybncsIqqOQx+qTIpAaZnRFEo0sQlvSeLSNQmGJ60NkEKkPq4Wgq
         JcAqhDO00V/6Q==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44936
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

On 12/21/2014 12:16, Rickard Strandqvist wrote:
> Removes some functions that are not used anywhere:
> ArcSetFileInformation() ArcGetFileInformation() ArcSeek()
> ArcGetReadStatus() ArcClose() ArcOpen() ArcGetDirectoryEntry()
> 
> This was partially found by using a static code analysis program called cppcheck.

A lot of these functions are for the ARCS PROM used in SGI systems.  They might
be unused functionally, but probably provide some kind of documentation on
known ARCS internals.  Or maybe, one day, they'll have a purpose if we ever try
to utilize ARCS for other things.

--J



> Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
> ---
>  arch/mips/fw/arc/file.c |   43 -------------------------------------------
>  1 file changed, 43 deletions(-)
> 
> diff --git a/arch/mips/fw/arc/file.c b/arch/mips/fw/arc/file.c
> index 49fd3ff..ebd69de 100644
> --- a/arch/mips/fw/arc/file.c
> +++ b/arch/mips/fw/arc/file.c
> @@ -13,62 +13,19 @@
>  #include <asm/sgialib.h>
>  
>  LONG
> -ArcGetDirectoryEntry(ULONG FileID, struct linux_vdirent *Buffer,
> -		     ULONG N, ULONG *Count)
> -{
> -	return ARC_CALL4(get_vdirent, FileID, Buffer, N, Count);
> -}
> -
> -LONG
> -ArcOpen(CHAR *Path, enum linux_omode OpenMode, ULONG *FileID)
> -{
> -	return ARC_CALL3(open, Path, OpenMode, FileID);
> -}
> -
> -LONG
> -ArcClose(ULONG FileID)
> -{
> -	return ARC_CALL1(close, FileID);
> -}
> -
> -LONG
>  ArcRead(ULONG FileID, VOID *Buffer, ULONG N, ULONG *Count)
>  {
>  	return ARC_CALL4(read, FileID, Buffer, N, Count);
>  }
>  
>  LONG
> -ArcGetReadStatus(ULONG FileID)
> -{
> -	return ARC_CALL1(get_rstatus, FileID);
> -}
> -
> -LONG
>  ArcWrite(ULONG FileID, PVOID Buffer, ULONG N, PULONG Count)
>  {
>  	return ARC_CALL4(write, FileID, Buffer, N, Count);
>  }
>  
>  LONG
> -ArcSeek(ULONG FileID, struct linux_bigint *Position, enum linux_seekmode SeekMode)
> -{
> -	return ARC_CALL3(seek, FileID, Position, SeekMode);
> -}
> -
> -LONG
>  ArcMount(char *name, enum linux_mountops op)
>  {
>  	return ARC_CALL2(mount, name, op);
>  }
> -
> -LONG
> -ArcGetFileInformation(ULONG FileID, struct linux_finfo *Information)
> -{
> -	return ARC_CALL2(get_finfo, FileID, Information);
> -}
> -
> -LONG ArcSetFileInformation(ULONG FileID, ULONG AttributeFlags,
> -			   ULONG AttributeMask)
> -{
> -	return ARC_CALL3(set_finfo, FileID, AttributeFlags, AttributeMask);
> -}
> 


-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
4096R/D25D95E3 2011-03-28

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
