Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Mar 2007 10:04:00 +0100 (BST)
Received: from nz-out-0506.google.com ([64.233.162.225]:23017 "EHLO
	nz-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20022622AbXCZJD7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 26 Mar 2007 10:03:59 +0100
Received: by nz-out-0506.google.com with SMTP id x7so1390947nzc
        for <linux-mips@linux-mips.org>; Mon, 26 Mar 2007 02:02:57 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qd2txFqlwoTpAbnIrEkeBvVsGdMbCqq4NO9Dr9GOFYIitPHjfxwoXKI09t1ub0SqkIZXa0J9/u3zmDbiSnotN8zPa5M/+huImYpA4WSONZIYRN/jXS/ifyPP4SXfSMA6ZfL/KBIrke3guGJZX68SBPqb6T6oo5JQpP8uhRzhtRM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GpU31VUAt5meCOPMDRDB5IYNs2V0mlsTjiTHTXDvT05xvOjpCBsv02ZGOuLlHOf3UVu59eEN03t0Qy011Z5FcRgk7ofCBQf9UVsMX1g2i/yx/FYBjusR8dwCaeWcAT/Z5ww5HxMEoTrM9x81ldepgGTJ9ZuL3+ANmv1K+n9xcCM=
Received: by 10.114.202.15 with SMTP id z15mr2547289waf.1174899776786;
        Mon, 26 Mar 2007 02:02:56 -0700 (PDT)
Received: by 10.114.136.11 with HTTP; Mon, 26 Mar 2007 02:02:56 -0700 (PDT)
Message-ID: <cda58cb80703260202tb89e38cw9d82074d7b20911f@mail.gmail.com>
Date:	Mon, 26 Mar 2007 11:02:56 +0200
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	Kumba <kumba@gentoo.org>
Subject: Re: [PATCH]: Remove CONFIG_BUILD_ELF64 entirely
Cc:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org,
	ths@networkno.de, ralf@linux-mips.org
In-Reply-To: <4606AA74.3070907@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20070324.234727.25910303.anemo@mba.ocn.ne.jp>
	 <20070324231602.GP2311@networkno.de> <46062400.8080307@gentoo.org>
	 <20070326.011000.75185255.anemo@mba.ocn.ne.jp>
	 <4606AA74.3070907@gentoo.org>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14679
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 3/25/07, Kumba <kumba@gentoo.org> wrote:
> I missed the other two additions to this patch, which is probably why it didn't
> work :)  Taken as a whole, they also boot my O2 now.
>

Argh !

-- 
               Franck
