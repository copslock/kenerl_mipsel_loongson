Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Oct 2014 13:07:51 +0200 (CEST)
Received: from mail-wi0-f171.google.com ([209.85.212.171]:54898 "EHLO
        mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012029AbaJULHsPOR7S (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Oct 2014 13:07:48 +0200
Received: by mail-wi0-f171.google.com with SMTP id em10so9657133wid.10
        for <linux-mips@linux-mips.org>; Tue, 21 Oct 2014 04:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=0tLSSnNlSMioxxXC0Yq088vNOdLr6U/Cmy/PC+nrCXY=;
        b=LmZbObZXtvvJ5x1RgY9AH/20pSUiXuaPDCBcV9t6kwMstuHnYuoGTTe3+lkJsvzd9C
         UivghwdJaRpOSUjJt87rBkZ71nQm+C2ue4jNlg2SyEXvMTLtwoeFgQwx82t0Phv6CSCg
         gGLVe33rrIGsKa7H9g7UJBPXjaU3xAoT2O/flyRBsizk4KmAfwkOM+N4PrIXJH6TFeqr
         fZ+mHb/KWl1ATCN1FUl/X7eFbkgkKs9ckQSIxETaNr/1XSXFMGA7F69dCC3tsE+2hJg8
         AENwkUlT37VpJB29H83xJTqS8Za4L4eRKxa97E6kLIYU8mSjKonS17f/GIXvHDYUEnF0
         WeZA==
X-Received: by 10.194.237.9 with SMTP id uy9mr40711799wjc.69.1413889660238;
        Tue, 21 Oct 2014 04:07:40 -0700 (PDT)
Received: from netboy (197.56.253.84.static.wline.lns.sme.cust.swisscom.ch. [84.253.56.197])
        by mx.google.com with ESMTPSA id hu3sm15019346wjb.17.2014.10.21.04.07.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 21 Oct 2014 04:07:39 -0700 (PDT)
Date:   Tue, 21 Oct 2014 13:07:25 +0200
From:   Richard Cochran <richardcochran@gmail.com>
To:     Markos Chandras <markos.chandras@imgtec.com>
Cc:     linux-mips@linux-mips.org, Jonathan Corbet <corbet@lwn.net>,
        netdev@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: ptp: Fix build failure on MIPS cross
 builds
Message-ID: <20141021110724.GA16479@netboy>
References: <1413794538-28465-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1413794538-28465-1-git-send-email-markos.chandras@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <richardcochran@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43420
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: richardcochran@gmail.com
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

On Mon, Oct 20, 2014 at 09:42:18AM +0100, Markos Chandras wrote:
> diff --git a/Documentation/ptp/Makefile b/Documentation/ptp/Makefile
> index 293d6c09a11f..397c1cd2eda7 100644
> --- a/Documentation/ptp/Makefile
> +++ b/Documentation/ptp/Makefile
> @@ -1,5 +1,15 @@
>  # List of programs to build
> +ifndef CROSS_COMPILE
>  hostprogs-y := testptp
> +else
> +# MIPS system calls are defined based on the -mabi that is passed
> +# to the toolchain which may or may not be a valid option
> +# for the host toolchain. So disable testptp if target architecture
> +# is MIPS but the host isn't.
> +ifndef CONFIG_MIPS
> +hostprogs-y := testptp
> +endif
> +endif

It seems like a shame to simply give up and not compile this at all.
Is there no way to correctly cross compile this for MIPS?

Thanks,
Richard
