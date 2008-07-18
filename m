Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Jul 2008 14:28:57 +0100 (BST)
Received: from fg-out-1718.google.com ([72.14.220.152]:48713 "EHLO
	fg-out-1718.google.com") by ftp.linux-mips.org with ESMTP
	id S20027081AbYGRN2x convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 18 Jul 2008 14:28:53 +0100
Received: by fg-out-1718.google.com with SMTP id d23so150371fga.32
        for <linux-mips@linux-mips.org>; Fri, 18 Jul 2008 06:28:52 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:reply-to:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id:sender;
        bh=ytVBFJh5dEPNfuS0kR7ghxNpGs7IbXJ6GGYNUa8tJLE=;
        b=NlJ1e7PPU7h6wMy78S1S5Hw63Q7/1hlOuX6OOMxRKMDzCCNiHnkYo86t9qgr3w27qK
         knQmW8H5OpvtVrMkTa29EmhrfJpk0XiGANT5I6WjWZiFFSargZJ8TDfcCV+Jz9XttPq9
         rJw3DPWYmftHVVKdPGFGPj01n+/LqsGhEVaHU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:reply-to:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id:sender;
        b=GG/prTsKWK420mpiWePP3DrF9oMIHjCBUsh28e7jXLNNd+hnLElQd4omprLFnbcHi5
         u03aH1hPLY8e69+oj3Fk6v41d+qH3SWjofeTo73KZB2EKcVI/9InXPDZEte7mqM0XYMI
         3avSGCh1BtrvjC3PJyrgsGiNOAfrBdF7fDAuM=
Received: by 10.86.33.10 with SMTP id g10mr371778fgg.14.1216387732200;
        Fri, 18 Jul 2008 06:28:52 -0700 (PDT)
Received: from innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTPS id 12sm51049fgg.0.2008.07.18.06.28.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 18 Jul 2008 06:28:51 -0700 (PDT)
From:	Brian Foster <brian.foster@innova-card.com>
Reply-To: Brian Foster <brian.foster@innova-card.com>
To:	"Daniel Laird" <daniel.j.laird@nxp.com>
Subject: Re: HOWTO submit patches using WebMail - Help appreciated?
Date:	Fri, 18 Jul 2008 15:28:40 +0200
User-Agent: KMail/1.9.6 (enterprise 0.20070907.709405)
Cc:	"Ralf Baechle" <ralf@linux-mips.org>, linux-mips@linux-mips.org
References: <64660ef00807171259l55f85380l47cfdc7574f84099@mail.gmail.com>
In-Reply-To: <64660ef00807171259l55f85380l47cfdc7574f84099@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200807181528.41119.brian.foster@innova-card.com>
Return-Path: <blf.ireland@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19879
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brian.foster@innova-card.com
Precedence: bulk
X-list: linux-mips

On Thursday 17 July 2008 21:59:45 Daniel Laird wrote:
> 
> I am having issues getting patches to the mailing list in a format
> that seems to be acceptable.
> I have done all I can to the patch itself but I am having mail client
> issues as well.
> I have tried Gmail with plaintext.  [ ... ]
> 
> Is there anyone who has used a web mail client and had success, most
> details out there [ ... not for ] people with Work based mail accounts.

Dan,

  Guessing a bit, that sounds a lot like the problem I had:
 It was (and still is) impossible to use the company's SMTP
 MTA to send a patch (or even an acceptable list posting),
 even if the client (MUA) wasn't going to mess things up.

  But, if you have a Gmail account, it can be done!  In fact,
 that is what I'm doing to send this reply:  Using the MUA at
 the company, but *not* using the company's SMTP.  The secret
 is Gmail now has SMTP (and IMAP) support, as well as the POP
 support they've had for awhile.  You need to enable the SMTP
 for your Gmail account, and arrange for a non-corrupting MUA
 to use Gmail's SMTP, and (assuming your company's firewall
 et al. doesn't cause issues), things may just work.

Good luck & cheers!
	-blf-

-- 
“How many surrealists does it take to   | Brian Foster
 change a lightbulb? Three. One calms   | somewhere in south of France
 the warthog, and two fill the bathtub  |   Stop E$$o (ExxonMobil)!
 with brightly-coloured machine tools.” |      http://www.stopesso.com
