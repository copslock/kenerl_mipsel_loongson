Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 May 2014 00:52:30 +0200 (CEST)
Received: from mail-wg0-f45.google.com ([74.125.82.45]:41566 "EHLO
        mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6855083AbaETWwZRa119 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 May 2014 00:52:25 +0200
Received: by mail-wg0-f45.google.com with SMTP id m15so1220056wgh.16
        for <linux-mips@linux-mips.org>; Tue, 20 May 2014 15:52:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :organization:user-agent:in-reply-to:references:mime-version
         :content-type;
        bh=g3RMaIDIsN/mje8wIfBP31yqQz7vB3Q3cccHl28unrs=;
        b=geyLIxwbGdQbuKlFejJcY/JmYLl2MqX8vNKJfbmPZJBS3Rfc4P8WiN4/846/73jbIn
         mRRFDnP2y2lon/ZdBtc5t3sKfoJH3JBEQG70OMy8soWj0OSVpuAzTmpYs4Ctlcn0VWdv
         iQNz+EB2ixx3Wkfsx8JbCTNOfKDJBwDL0JRCr1dhQBtfmnSsAVuPwsh7wJR2GhJKrl3m
         cUuP2AKoLsV5+myBMd0IVMGGuQ0KPA4iYF6iErexQowAZDJUICjoD6C5V814U8jiQ1wh
         QwgRWJTOiz2cRhBxz9P7FuGYLnynHcTMdKYnVju7ZwadSjSz2qJ6R+Hhad9ycpD34WYJ
         Bwaw==
X-Gm-Message-State: ALoCoQnHu8Wz0fvGZdTC7bzJz3FH/+dlIL3TTPGKMecEsPb/7GO+W02PSnXWNDq3y2RdqVR6CFwQ
X-Received: by 10.194.6.166 with SMTP id c6mr12875744wja.64.1400626337924;
        Tue, 20 May 2014 15:52:17 -0700 (PDT)
Received: from radagast.localnet (jahogan.plus.com. [212.159.75.221])
        by mx.google.com with ESMTPSA id na4sm138724wic.21.2014.05.20.15.52.16
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 20 May 2014 15:52:16 -0700 (PDT)
From:   James Hogan <james.hogan@imgtec.com>
To:     linux-mips@linux-mips.org
Cc:     Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        David Daney <ddaney.cavm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, kvm@vger.kernel.org,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 03/15] MIPS: OCTEON: Move CAVIUM_OCTEON_CVMSEG_SIZE to CPU_CAVIUM_OCTEON
Date:   Tue, 20 May 2014 23:52:06 +0100
Message-ID: <3124276.AVUgu1xWyv@radagast>
Organization: Imagination Technologies
User-Agent: KMail/4.12.5 (Linux/3.15.0-rc5+; KDE/4.12.5; x86_64; ; )
In-Reply-To: <1400597236-11352-4-git-send-email-andreas.herrmann@caviumnetworks.com>
References: <1400597236-11352-1-git-send-email-andreas.herrmann@caviumnetworks.com> <1400597236-11352-4-git-send-email-andreas.herrmann@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1662602.Q1P5RV4oJy"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Return-Path: <james@albanarts.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40195
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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


--nextPart1662602.Q1P5RV4oJy
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Andreas,

On Tuesday 20 May 2014 16:47:04 Andreas Herrmann wrote:
> From: David Daney <david.daney@cavium.com>
> 
> CVMSEG is related to the CPU core not the SoC system.  So needs to be
> configurable there.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> Signed-off-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
> ---
>  arch/mips/cavium-octeon/Kconfig |   30 ++++++++++++++++++++----------
>  1 file changed, 20 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/mips/cavium-octeon/Kconfig
> b/arch/mips/cavium-octeon/Kconfig index 227705d..c5e9975 100644
> --- a/arch/mips/cavium-octeon/Kconfig
> +++ b/arch/mips/cavium-octeon/Kconfig
> @@ -10,6 +10,17 @@ config CAVIUM_CN63XXP1
>  	  non-CN63XXP1 hardware, so it is recommended to select "n"
>  	  unless it is known the workarounds are needed.
> 
> +config CAVIUM_OCTEON_CVMSEG_SIZE
> +	int "Number of L1 cache lines reserved for CVMSEG memory"
> +	range 0 54
> +	default 1
> +	help
> +	  CVMSEG LM is a segment that accesses portions of the dcache as a
> +	  local memory; the larger CVMSEG is, the smaller the cache is.
> +	  This selects the size of CVMSEG LM, which is in cache blocks. The
> +	  legally range is from zero to 54 cache blocks (i.e. CVMSEG LM is
> +	  between zero and 6192 bytes).
> +
>  endif # CPU_CAVIUM_OCTEON
> 
>  if CAVIUM_OCTEON_SOC
> @@ -23,16 +34,16 @@ config CAVIUM_OCTEON_2ND_KERNEL
>  	  with this option to be run at the same time as one built without this
>  	  option.
> 
> -config CAVIUM_OCTEON_CVMSEG_SIZE
> -	int "Number of L1 cache lines reserved for CVMSEG memory"
> -	range 0 54
> -	default 1
> +config CAVIUM_OCTEON_HW_FIX_UNALIGNED
> +	bool "Enable hardware fixups of unaligned loads and stores"
> +	default "y"

Is adding CAVIUM_OCTEON_HW_FIX_UNALIGNED in this patch intentional? It seems 
unrelated.

Cheers
James

>  	help
> -	  CVMSEG LM is a segment that accesses portions of the dcache as a
> -	  local memory; the larger CVMSEG is, the smaller the cache is.
> -	  This selects the size of CVMSEG LM, which is in cache blocks. The
> -	  legally range is from zero to 54 cache blocks (i.e. CVMSEG LM is
> -	  between zero and 6192 bytes).
> +	  Configure the Octeon hardware to automatically fix unaligned loads
> +	  and stores. Normally unaligned accesses are fixed using a kernel
> +	  exception handler. This option enables the hardware automatic fixups,
> +	  which requires only an extra 3 cycles. Disable this option if you
> +	  are running code that relies on address exceptions on unaligned
> +	  accesses.
> 
>  config CAVIUM_OCTEON_LOCK_L2
>  	bool "Lock often used kernel code in the L2"
> @@ -86,7 +97,6 @@ config SWIOTLB
>  	select IOMMU_HELPER
>  	select NEED_SG_DMA_LENGTH
> 
> -
>  config OCTEON_ILM
>  	tristate "Module to measure interrupt latency using Octeon CIU Timer"
>  	help

--nextPart1662602.Q1P5RV4oJy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAABAgAGBQJTe9yeAAoJEGwLaZPeOHZ6HHAQAKMtP+jOxvg+2if7hIKnHr2D
yfzeBXyz+neSVVeoY1obfOz/+Zy+cSSpQTw6Qz0aJELrBS+k+bXCVCIPQBChoJ3A
MdpzbGlqGZlg+g0+OLk4nWzrNtUNyj178b63Rfg/vdF0j9uEPhrWCbJXTAm6gFU8
HHYUKhTKmp0IfFr7dqGN0yT7ucEGrORoPuZ3iilVKQVX4/bQd3goPJIyk9UZXfuK
EEgb7gGjlTQpsG7C9RjQPYdVHmlOkBgvfPKNCbWHl9lOH+TdbCUNF9mV2DjGztE5
/JTJmr0NRh3MkLPa+1wuW19bfwgpidOkF5OZB8uaNyXakGCU/r1tu+0/ZOBkkwzm
fgHVEtEa8+cUaerSMpYGnm/LQ9CR1sqB5wLX0vXfcjMeha0S6du77Uz1JqM0OTVp
oiLfF+xjjYAbSdLRFM99VzRs+f6GvqFIiRyjbLCvlPj7K15SmhV+B8+VXkSYctN8
adxlMxW1/hwU2fgIQm61yUZg9Xn9NaXgOTLlvngVyJ5l8Isz5pyobZPcif1YlzSy
jA3wJkOibZPTuJjN/6GojMyh+NxmFIdV4+2XrmkcJ5RZnpuhNjTVew/h7k1NH0z5
v11sW8i/cCxYwqedhBrJIB9hZEc9SEWBlCbDFWNi2LUq8mrkCUcAAMqWTlDwQxJX
aaUtIgV9gEdFqeaCCkkX
=dWo4
-----END PGP SIGNATURE-----

--nextPart1662602.Q1P5RV4oJy--
