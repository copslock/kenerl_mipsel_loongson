Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Feb 2016 12:38:27 +0100 (CET)
Received: from mail-lf0-f53.google.com ([209.85.215.53]:35757 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010877AbcBBLiXke9Bl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Feb 2016 12:38:23 +0100
Received: by mail-lf0-f53.google.com with SMTP id l143so49302555lfe.2
        for <linux-mips@linux-mips.org>; Tue, 02 Feb 2016 03:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=NKlYmlM5QF/LZAaY+e8e1lnihXga66BN0owoC5Gax30=;
        b=QsayLd3H1O4x/QI2qgDN+nWZQJ+QkHDU0hmQ8o3eCFhMzbAIwImnfbmworYInhPewB
         KIRW9AOX3OsaIGRGrmf32lUKsGK+2jax7fGfazo1mwhCptZ1GalTQz8nx7Zr06sGN6ve
         CNAefbXCgrP1NEFOPm+RWpTupW80WLqL8UBekB/xVXY3G3LlRuR6P7thePVEy72RPZLg
         h+0XmCu8h6OgI/FZuWppLt8UMKdVV7nqH5as5ssRgwF7AlYN2C+lEF/15cAgxUsu9iXC
         cwHHsrdLWRYz768Oucp+5oC4w8bZ2sxSuesjxS0Yqduv7m9tFiookqss9GnRQii06qq3
         zNwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=NKlYmlM5QF/LZAaY+e8e1lnihXga66BN0owoC5Gax30=;
        b=ANFxr7HCLxQvgbzQyYmq50xUcv+bJ4wyC2YRqJDFzG72aRFXz8moK07qu0L/rdXm6G
         iZvb830NurF/3Toyh75N7KLEST1fQwVsbvItEXiW77sZ+nO/6MapkyhfAyP+VOizbRj/
         j6+ojK3P9J2pqp4pCx3n40MtH+ShbHhVBedeGDRFgHqX8E6QNLJN+L15b5crNp+iNm+w
         wNFCcUUIvaKpUt38qLVVNT9U+HXRpS0lzz268gD/8s0latkAPBatkLgtXAkoc+3BLAxP
         m5mnPGLk2cnkJalRBTzzoddGZ6Xm0onLQ2BESXsNMeMfDn1PcYmbYMAycrsOewYtHA4n
         pwog==
X-Gm-Message-State: AG10YOSCQ3mxLiDivTuRF4v6ylnLyAoovPHQ2ms6fT1lavpm3TuK9RMJ55daA8uqzGr/qA==
X-Received: by 10.25.141.129 with SMTP id p123mr8864241lfd.65.1454413098093;
        Tue, 02 Feb 2016 03:38:18 -0800 (PST)
Received: from [192.168.4.126] ([31.173.84.176])
        by smtp.gmail.com with ESMTPSA id ug1sm144265lbb.43.2016.02.02.03.38.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 02 Feb 2016 03:38:16 -0800 (PST)
Subject: Re: [PATCH] MIPS: Octeon: Add Octeon III CN7XXX interface detection
To:     Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        david.daney@cavium.com
References: <1454412318-27213-1-git-send-email-Zubair.Kakakhel@imgtec.com>
Cc:     janne.huttunen@nokia.com, aaro.koskinen@nokia.com,
        ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <56B09528.1030902@cogentembedded.com>
Date:   Tue, 2 Feb 2016 14:38:16 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <1454412318-27213-1-git-send-email-Zubair.Kakakhel@imgtec.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51626
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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

Hello.

On 2/2/2016 2:25 PM, Zubair Lutfullah Kakakhel wrote:

> Add basic CN7XXX interface detection.
>
> This allows the kernel to boot with ethernet working as it initializes
> the ethernet ports with SGMII instead of defaulting to RGMII routines.
>
> Tested on the utm8 from Rhino Labs with a CN7130.
>
> Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
> ---
>   arch/mips/cavium-octeon/executive/cvmx-helper.c | 41 +++++++++++++++++++++++++
>   1 file changed, 41 insertions(+)
>
> diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper.c b/arch/mips/cavium-octeon/executive/cvmx-helper.c
> index 376701f..1a28009 100644
> --- a/arch/mips/cavium-octeon/executive/cvmx-helper.c
> +++ b/arch/mips/cavium-octeon/executive/cvmx-helper.c
[...]
> @@ -260,6 +262,39 @@ static cvmx_helper_interface_mode_t __cvmx_get_mode_octeon2(int interface)
>   }
>
>   /**
> + * @INTERNAL
> + * Return interface mode for CN7XXX.
> + */
> +static cvmx_helper_interface_mode_t __cvmx_get_mode_cn7xxx(int interface)

    Not *unsigned*?

> +{
> +	union cvmx_gmxx_inf_mode mode;
> +
> +	mode.u64 = cvmx_read_csr(CVMX_GMXX_INF_MODE(interface));
> +
> +	if (interface < 2) {		/* SGMII/QSGMII/XAUI */
> +		switch (mode.cn68xx.mode) {
> +		case 0:
> +			return CVMX_HELPER_INTERFACE_MODE_DISABLED;
> +		case 1:
> +		case 2:
> +			return CVMX_HELPER_INTERFACE_MODE_SGMII;
> +		case 3:
> +			return CVMX_HELPER_INTERFACE_MODE_XAUI;
> +		default:
> +			return CVMX_HELPER_INTERFACE_MODE_SGMII;
> +		}
> +	} else if (interface == 2)	/* NPI */
> +		return CVMX_HELPER_INTERFACE_MODE_NPI;
> +	else if (interface == 3)	/* LOOP */
> +		return CVMX_HELPER_INTERFACE_MODE_LOOP;
> +	else if (interface == 4)	/* RGMII (AGL) */
> +		return CVMX_HELPER_INTERFACE_MODE_RGMII;

    This is asking to be a *switch* statement.

> +
> +	return CVMX_HELPER_INTERFACE_MODE_DISABLED;
> +}
> +
> +
> +/**
>    * Get the operating mode of an interface. Depending on the Octeon
>    * chip and configuration, this function returns an enumeration
>    * of the type of packet I/O supported by an interface.
[...]

MBR, Sergei
