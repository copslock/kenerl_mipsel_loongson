Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jun 2007 15:25:58 +0100 (BST)
Received: from py-out-1112.google.com ([64.233.166.183]:29927 "EHLO
	py-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20022465AbXFOOZi (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 15 Jun 2007 15:25:38 +0100
Received: by py-out-1112.google.com with SMTP id f31so1704640pyh
        for <linux-mips@linux-mips.org>; Fri, 15 Jun 2007 07:24:37 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dt+KFBnjWIEpgFNdPW9D9wz0DicTX/T/Nd9lNDD+XHtigCGikJL44orFviklQTUsHDuSc/5DzOpd8Fop02R/FEQeg7zB+nfJTC/ksoq63FJAAv5sVUfdfJtx1qkal7qIRCkCuVzKG7kT3CpR2I9qNf9Oy03qmf/eAaUWM9GZGy8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lXo1j4kr+lJNnd21Da2xLWF/C9b/ThuT3uSg9SE6Rnx1bgwZ0pOCg61XIJhdnqisEIe0m9/Tz47M2FR/sp/HZ3UFSC61NSdJCM3Lh4VbxdLvzxj2HWFdajmQIGjtMUujcJFSUONmHcBmlMIHarkBdtitThPoFf6HD/TPBMyj5w0=
Received: by 10.64.143.12 with SMTP id q12mr5309201qbd.1181917476924;
        Fri, 15 Jun 2007 07:24:36 -0700 (PDT)
Received: by 10.65.204.8 with HTTP; Fri, 15 Jun 2007 07:24:36 -0700 (PDT)
Message-ID: <cda58cb80706150724i1cbbfd1aw51d23d18e35f6266@mail.gmail.com>
Date:	Fri, 15 Jun 2007 16:24:36 +0200
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: [PATCH 3/5] Deforest the function pointer jungle in the time code.
Cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	"Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
	linux-mips@linux-mips.org
In-Reply-To: <20070615132613.GA16133@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <11818164011355-git-send-email-fbuihuu@gmail.com>
	 <11818164023940-git-send-email-fbuihuu@gmail.com>
	 <20070614111748.GA8223@alpha.franken.de>
	 <cda58cb80706140643g63c3bf34sbd5b843a15653c3d@mail.gmail.com>
	 <Pine.LNX.4.64N.0706141501080.25868@blysk.ds.pg.gda.pl>
	 <cda58cb80706140731j1b6e8e36l96d4423db1ffd9e7@mail.gmail.com>
	 <Pine.LNX.4.64N.0706141648540.25868@blysk.ds.pg.gda.pl>
	 <cda58cb80706150159j5c3d5b7p4293dc529d5ee97c@mail.gmail.com>
	 <Pine.LNX.4.64N.0706151117180.3754@blysk.ds.pg.gda.pl>
	 <20070615132613.GA16133@linux-mips.org>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15423
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 6/15/07, Ralf Baechle <ralf@linux-mips.org> wrote:
>
> For some reason the calibration turned out to be rather trick on Indys, so
> arch/mips/sgi-ip22/ip22-time.c's plat_time_init is a well working example
> for calibration of the cp0 timer against a timer of know speed.
>

Do you think it's possible to work out a common version of this
calibration without to many hacks ? Or should we simply move the
current generic one into the dec code and resolve this point later ?
-- 
               Franck
