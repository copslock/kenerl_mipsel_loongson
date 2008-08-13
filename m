Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Aug 2008 16:12:35 +0100 (BST)
Received: from fg-out-1718.google.com ([72.14.220.157]:29729 "EHLO
	fg-out-1718.google.com") by ftp.linux-mips.org with ESMTP
	id S28593068AbYHMPM3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 13 Aug 2008 16:12:29 +0100
Received: by fg-out-1718.google.com with SMTP id d23so40890fga.32
        for <linux-mips@linux-mips.org>; Wed, 13 Aug 2008 08:12:27 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:reply-to:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id:sender;
        bh=eXZSNNYkoMD9Hd5tzeJTtQzVia1VjeLal8Fi31EjVIE=;
        b=pK0qPf0wF5inUvCQOwD3qEBtJo9ZLMdM36iLCdVYm/SXcKGD5PKFh1ssT/kwUAKnIG
         SQpu7FDdKuYt1M0pVY3xmE4YqqpDtujRIzGoR63a+cyKPNShzj4VNDVkaDYK/XkkBbJB
         q0hMXwo7xmYp9owh3yex0OTs75e8IZLrJMRwU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:reply-to:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id:sender;
        b=frYir0hMM7cxQrbwX7S30jDr6Cnxi+IhP90kY4GMDeD34ntrCgreQKlTOv2l/DUYqv
         vmeVUsgeg11sTGGdobySZzQUZ9iHjYFjQq2q5DTzLM6xvfwVaRRx/MHaKGkCVjwcJbbg
         FM3xr4OWNfma7Rm1AbNO29AWJ8TMBisX+CpsQ=
Received: by 10.86.83.2 with SMTP id g2mr99565fgb.54.1218640347420;
        Wed, 13 Aug 2008 08:12:27 -0700 (PDT)
Received: from innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTPS id d4sm1181466fga.8.2008.08.13.08.12.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 13 Aug 2008 08:12:26 -0700 (PDT)
From:	Brian Foster <brian.foster@innova-card.com>
Reply-To: Brian Foster <brian.foster@innova-card.com>
To:	jfraser@broadcom.com
Subject: Re: Debugging the MIPS processor using GDB
Date:	Wed, 13 Aug 2008 17:12:34 +0200
User-Agent: KMail/1.9.6 (enterprise 0.20070907.709405)
Cc:	linux-mips@linux-mips.org,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	TriKri <kristoferkrus@hotmail.com>
References: <18944199.post@talk.nabble.com> <200808130905.53671.brian.foster@innova-card.com> <1218638494.21039.6.camel@chaos.ne.broadcom.com>
In-Reply-To: <1218638494.21039.6.camel@chaos.ne.broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200808131712.34722.brian.foster@innova-card.com>
Return-Path: <blf.ireland@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20204
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brian.foster@innova-card.com
Precedence: bulk
X-list: linux-mips

On Wednesday 13 August 2008 16:41:34 Jon Fraser wrote:
> I use the FS2 probe with sde-gdb on a nearly daily basis.
> Are you compiling your kernel with -g -O1 ?

Jon,

  ‘-g’, yes.  ‘-O1’?  Not sure, I will have to check when
 I get a chance.  (But I don't see how either would have
 the effect on breakpoints I'm suffering from?)

> You can also try 'hbreak' instead of 'break' in sde-gdb.

  I'll have to (re-)try that when I get a chance.  I did
 try it once, and have (very! vague!!) memories of some
 issue, but now cannot recall anything useful.  ;-\ 

cheers!
	-blf-

-- 
“How many surrealists does it take to   | Brian Foster
 change a lightbulb? Three. One calms   | somewhere in south of France
 the warthog, and two fill the bathtub  |   Stop E$$o (ExxonMobil)!
 with brightly-coloured machine tools.” |      http://www.stopesso.com
