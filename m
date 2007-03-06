Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Mar 2007 11:07:27 +0000 (GMT)
Received: from nf-out-0910.google.com ([64.233.182.186]:37764 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20021344AbXCFLHZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 6 Mar 2007 11:07:25 +0000
Received: by nf-out-0910.google.com with SMTP id l24so2325694nfc
        for <linux-mips@linux-mips.org>; Tue, 06 Mar 2007 03:06:25 -0800 (PST)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=odHefe32hztH4osQHubEk7v7CPspyKT0sF1X6iX8zZmyWJ4OGTadmuVFXACxvFr786pCf46Ab04i7D5np2YkioyehCK8fGj/gXnt7A+8eDMaAxVpicsVjDRMo+U+F+fpCwMeMH31bfeaxb25X3L1LafNovFiE1uKuZlDFhe1Tuc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AB8aF3E56A72N+hsI6kGuBGEA+MrYrvCgWOPu5DVyf9rj5vCRcAUgOc0MESaouJhrdB89IPSo/X2WrDZ47ysT8tyfSqwo82wvh2caUgVgGUXYJpnpc8DTsyVlyVyPkjp1sf6R8sBQujh4te9QE5ogaku7QGI/hh6emId41dlUa8=
Received: by 10.78.138.6 with SMTP id l6mr765057hud.1173179185385;
        Tue, 06 Mar 2007 03:06:25 -0800 (PST)
Received: by 10.78.44.13 with HTTP; Tue, 6 Mar 2007 03:06:25 -0800 (PST)
Message-ID: <c4357ccd0703060306x6135cf22p39d55ff79ed7ad45@mail.gmail.com>
Date:	Tue, 6 Mar 2007 13:06:25 +0200
From:	"Alexander Sirotkin" <demiourgos@gmail.com>
To:	linux-mips@linux-mips.org
Subject: Re: 0 function size
In-Reply-To: <20070305162745.GB786@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <c4357ccd0703050619r6b5a7452j6b582687bf1794d3@mail.gmail.com>
	 <b115cb5f0703050821v50667580oa8dfa26412c05b08@mail.gmail.com>
	 <20070305162745.GB786@linux-mips.org>
Return-Path: <demiourgos@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14368
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: demiourgos@gmail.com
Precedence: bulk
X-list: linux-mips

On 3/5/07, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Mon, Mar 05, 2007 at 09:51:25PM +0530, Rajat Jain wrote:
>
> > Are you using a native compiler or a cross compiler?
> >
> > If you are using a cross compiler, then you need to use the "cross
> > compiler" version of objdump / readelf  utilities as well. For
> > instance if you are using mips-linux-gcc to compile, then you need
> > mips-linux-readelf / mips-linux-objdump etc.
>
> In general your're right but for this particular purpose for example an
> i386-linux-objdump will do the job for 32-bit big and little endian
> MIPS ELF.  It will - depending on the exact binutils configuration - fail
> with an error message for 64-bit ELF.
>
>   Ralf
>

Apparently it is a bug in MIPS SDE toolchain, even in the latest version 6.05.
With emdebian toolchain it works just fine.
