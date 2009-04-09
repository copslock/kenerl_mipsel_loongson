Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Apr 2009 07:56:54 +0100 (BST)
Received: from mail-ew0-f174.google.com ([209.85.219.174]:46217 "EHLO
	mail-ew0-f174.google.com") by ftp.linux-mips.org with ESMTP
	id S20031418AbZDIG4c convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 9 Apr 2009 07:56:32 +0100
Received: by ewy22 with SMTP id 22so526623ewy.0
        for <linux-mips@linux-mips.org>; Wed, 08 Apr 2009 23:56:26 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:reply-to:to
         :subject:date:user-agent:cc:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        bh=55lNfOxEtZmwaRSc3ZjjuJzwDf23Wm3MMs5Sevf5cEg=;
        b=LOciK4eEpeCdKJhoDUuFoKSZbmwmp3dtJzBMMFKCrmCcZcrdMVU4Up7AuXsaaaU5xS
         HeiM6FWgE7AMPIRqKbwVc9HwwFTG/HjmU3UHnywqEfcDkdWDB7Bdjiu5mHpGTpm4TlU7
         4Y3C1SQijOyloI2ZPrWO14rDy4haahAQSsHTw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:reply-to:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=eNm/OfJnmyBPYP9biShY53U6xttJ7sBXs8RXI9KiWnkeBBSTlE0iPrIHw6PuxlCKf6
         35fPBOq9LvTH+AWQs1TaCCWNo/fgRaQrGslM2Z02OBUUGknGqFkWLPMfnhhKPtY/Z2h+
         FVSkeKg4Bdbvl1ZwH7efepqKekWD3QoabBQDU=
Received: by 10.210.66.13 with SMTP id o13mr180836eba.95.1239260186466;
        Wed, 08 Apr 2009 23:56:26 -0700 (PDT)
Received: from innova-card.com (LRouen-152-82-23-47.w80-13.abo.wanadoo.fr [80.13.118.47])
        by mx.google.com with ESMTPS id 7sm8649794ewy.58.2009.04.08.23.56.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 08 Apr 2009 23:56:25 -0700 (PDT)
From:	Brian Foster <brian.foster@innova-card.com>
Reply-To: Brian Foster <brian.foster@innova-card.com>
To:	David Wuertele <dave+gmane@wuertele.com>
Subject: Re: What is the right way to setup MIPS timer irq in 2.6.29?
Date:	Thu, 9 Apr 2009 08:55:58 +0200
User-Agent: KMail/1.10.4 (Linux/2.6.27-11-generic; KDE/4.1.4; x86_64; ; )
Cc:	linux-mips@linux-mips.org
References: <loom.20090408T165537-312@post.gmane.org>
In-Reply-To: <loom.20090408T165537-312@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200904090855.59093.brian.foster@innova-card.com>
Return-Path: <blf.ireland@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22301
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brian.foster@innova-card.com
Precedence: bulk
X-list: linux-mips

On Wednesday 08 April 2009 18:57:33 David Wuertele wrote:
> Has the system timer paradigm changed between 2.6.18 and 2.6.29?
> I'm trying to update my Broadcom-based embedded system to 2.6.29,
> and I'm running into problems getting the system timer to run.
> I'm looking for a clue about how to port forward my arch/mips/brcmstb/*
> files, specifically I want to write a plat_time_init() function
> that does for 2.6.29 what plat_timer_setup(struct irqaction *irq)
> did for 2.6.18.

David,

   This is just a guess....  The main change (that I know of)
  was in 2.6.24 to support “tickless idle”.  I just finished(?)
  fighting the battle to get the system timer to run reliably
  (discovering, in the process, a (minor) bug with our SoC ;-\ ).
  I've a meeting in a few minutes and so no time to write down
  any details (now), but hopefully Ralf or someone can either
  fill you in or point (both of us) to some doc.

cheers!
	-blf-
-- 
“How many surrealists does it take to   | Brian Foster
 change a lightbulb? Three. One calms   | somewhere in south of France
 the warthog, and two fill the bathtub  |   Stop E$$o (ExxonMobil)!
 with brightly-coloured machine tools.” |      http://www.stopesso.com
