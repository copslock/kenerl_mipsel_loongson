Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Jul 2008 19:09:41 +0100 (BST)
Received: from wr-out-0506.google.com ([64.233.184.226]:29835 "EHLO
	wr-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20024233AbYGJSJj (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 10 Jul 2008 19:09:39 +0100
Received: by wr-out-0506.google.com with SMTP id 58so2519262wri.8
        for <linux-mips@linux-mips.org>; Thu, 10 Jul 2008 11:09:37 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=MPa0EJA0Zz6mGe/OJXtfuXIU4UwXQLn4wGx3pydxTck=;
        b=MS7wPiK6sQBGoFkPHdpLotp22g2HZwtVMbwElCJyasKVwMmRw4fmE2ypjs/0B7xSTc
         6Yi68ew7wVUo5HiFIIc0PYUfoHhyB1I7husWr/Pp8CKsJcWMG5yttuuvY8psdXJUBXyF
         8djgjf6OPXjKWo3yooMdL+q1nfXuH6/GwJcQw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=jgTDIVcV5Okkd/td6v+JRU3k/pl3SvJPPRLWxp3gHlGByjXMZ6zYdxxWX7eP9ph0WJ
         m/VvfTykAmwLwGH2sfJdm+OD4K0xcQOOmGuzzY/ybscud/qMJxNKul8E85Z65xMkWA1g
         vwaNMUiVs3C2gPjg2+PXUNTJk3/GNAAaKCl68=
Received: by 10.90.51.13 with SMTP id y13mr9036852agy.67.1215713377658;
        Thu, 10 Jul 2008 11:09:37 -0700 (PDT)
Received: by 10.90.49.16 with HTTP; Thu, 10 Jul 2008 11:09:37 -0700 (PDT)
Message-ID: <118833cc0807101109m6abcda96w492548d847b1a8c4@mail.gmail.com>
Date:	Thu, 10 Jul 2008 14:09:37 -0400
From:	"Morten Welinder" <mwelinder@gmail.com>
To:	"Al Viro" <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] sparse: Increase pre_buffer[] and check overflow
Cc:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>,
	linux-sparse@vger.kernel.org, linux-mips@linux-mips.org
In-Reply-To: <20080710175100.GF28946@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20080709.002805.128619748.anemo@mba.ocn.ne.jp>
	 <20080709.005953.26097194.anemo@mba.ocn.ne.jp>
	 <20080710175100.GF28946@ZenIV.linux.org.uk>
Return-Path: <mwelinder@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19767
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mwelinder@gmail.com
Precedence: bulk
X-list: linux-mips

> Not used anywhere in the tree:
> -D__DBL_MIN_EXP__='(-1021)' -D__HQ_FBIT__='15' -D__SFRACT_IBIT__='0'
> -D__FLT_MIN__='1.17549435e-38F' -D__UFRACT_MAX__='0XFFFFP-16UR'
> -D__DEC64_DEN__='0.000000000000001E-383DD' -D__DQ_FBIT__='63'
> -D__ULFRACT_FBIT__='32' -D__SACCUM_EPSILON__='0x1P-7HK'
> -D__CHAR_BIT__='8' -D__USQ_IBIT__='0' -D__ACCUM_FBIT__='15'

Wrong tree, :-)  Check your equivalent of
/usr/lib64/gcc/x86_64-suse-linux/4.1.0/include/float.h

The kernel probably doesn't care much, but sparse as a general tool
ought to care.

Morten
