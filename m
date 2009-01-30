Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Jan 2009 08:27:45 +0000 (GMT)
Received: from ey-out-1920.google.com ([74.125.78.150]:50280 "EHLO
	ey-out-1920.google.com") by ftp.linux-mips.org with ESMTP
	id S21103039AbZA3I1n convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 30 Jan 2009 08:27:43 +0000
Received: by ey-out-1920.google.com with SMTP id 5so50747eyb.54
        for <multiple recipients>; Fri, 30 Jan 2009 00:27:42 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:reply-to:to
         :subject:date:user-agent:cc:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        bh=xAjoqaOnWFOodEKtVYB/U3DVSB83zGmSh5fuy46J/mY=;
        b=Au2Vv1l5cvOSRWyYlUrAGH6lWFX5xwDXPuGS0axNeaZvs69QIM5fWtex3qH5VInOcR
         HrA8dhTxx/dDIyM443RFoCGcjY1y5uB80Fs8B4dTZxgwkwZ+ndIth2JtogrQ4gpyLMaL
         Jtk5YDEDlvEM+Xt+UcgqGFQfS7wMEy3xNdlm4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:reply-to:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=g+i41Zz9AQ0x22JAM/fYS+S3ZOg4B+k+1UgSUYa1Sfnmtr95uoH3iJhGdNtAyTsoja
         VID1HBuiZLNaXugff2b54Hnk3WPzUoCgf6znlpS3l9Z0wGQ4yFHsZB/M/sWp6FHtTHR9
         5iWjDRxBVH7QsKECcq1S5lgaVm1Y4c9qqjXs0=
Received: by 10.210.112.1 with SMTP id k1mr1058208ebc.167.1233304062446;
        Fri, 30 Jan 2009 00:27:42 -0800 (PST)
Received: from innova-card.com (1-61.252-81.static-ip.oleane.fr [81.252.61.1])
        by mx.google.com with ESMTPS id 2sm1364750ewy.60.2009.01.30.00.27.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 30 Jan 2009 00:27:41 -0800 (PST)
From:	Brian Foster <brian.foster@innova-card.com>
Reply-To: Brian Foster <brian.foster@innova-card.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: Syntax error in include/asm-mips/gdb-stub.h
Date:	Fri, 30 Jan 2009 09:27:38 +0100
User-Agent: KMail/1.10.3 (Linux/2.6.27-11-generic; KDE/4.1.3; x86_64; ; )
Cc:	"Linux-MIPS" <linux-mips@linux-mips.org>
References: <200901291430.30275.brian.foster@innova-card.com> <20090129181830.GC4135@linux-mips.org>
In-Reply-To: <20090129181830.GC4135@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200901300927.39256.brian.foster@innova-card.com>
Return-Path: <blf.ireland@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21891
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brian.foster@innova-card.com
Precedence: bulk
X-list: linux-mips

On Thursday 29 January 2009 19:18:32 Ralf Baechle wrote:
> On Thu, Jan 29, 2009 at 02:30:29PM +0100, Brian Foster wrote:
> > apologies for not sending a patch [... fixing] missing semicolon (‘;’)
> > this mistake is seems to exist in at least the following  [ ... ]
> 
> Or in simpler words, in all -stable branches upto and including 2.6.26.

 yep.  thanks, that's a better way of putting it.  also thanks
 for fixing the issue.  again, apologies for sending a patch.
cheers!
	-blf-

-- 
“How many surrealists does it take to   | Brian Foster
 change a lightbulb? Three. One calms   | somewhere in south of France
 the warthog, and two fill the bathtub  |   Stop E$$o (ExxonMobil)!
 with brightly-coloured machine tools.” |      http://www.stopesso.com
