Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 Sep 2008 18:29:00 +0100 (BST)
Received: from fk-out-0910.google.com ([209.85.128.186]:63 "EHLO
	fk-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20132245AbYI0R2x (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 27 Sep 2008 18:28:53 +0100
Received: by fk-out-0910.google.com with SMTP id b27so2090504fka.0
        for <linux-mips@linux-mips.org>; Sat, 27 Sep 2008 10:28:52 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version
         :content-disposition:message-id:content-type
         :content-transfer-encoding;
        bh=poV7QGnwta0GKbX0Cp9vX/gabeukV9N1zveG2XoqGkk=;
        b=OISrOLDaAUcAdO8Fu+xemBrIGgJImbNaw4UKl89bbaYbmNlY3Cg0EcssuGw3RwjgPM
         WtcDNFcw2XTbTt2rquCbT++mYsF7OHjP8ed8ukO40yIAliURjtRG/IetHVi6+3RSOTK/
         QRRXVamdjpZ0ALSL2HjGnstU8EpuwbxRS2BB0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-disposition:message-id:content-type
         :content-transfer-encoding;
        b=rdSKYSuKjGHY/Kn4uUmBZrxBP8tXOdd7b/hRw8QwIJ9eOdb7ZngYe6q0vYuO0R9opM
         gsRyHNwlxF+2Je/p0XTstGPClwezjQ645BmQLUBBN4H+d7jkSeP1HMX8WUdAOx1Y0QHV
         +awMKDvNl9LDsgRIWh2ulf4q1zFWLOen8mo0k=
Received: by 10.103.222.12 with SMTP id z12mr2100456muq.12.1222536532233;
        Sat, 27 Sep 2008 10:28:52 -0700 (PDT)
Received: from ?192.168.123.7? (chello089077041080.chello.pl [89.77.41.80])
        by mx.google.com with ESMTPS id y37sm561478mug.13.2008.09.27.10.28.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 27 Sep 2008 10:28:51 -0700 (PDT)
From:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver (v2)
Date:	Sat, 27 Sep 2008 18:19:56 +0200
User-Agent: KMail/1.9.10
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org,
	linux-ide@vger.kernel.org, ralf@linux-mips.org
References: <20080918.001342.52129176.anemo@mba.ocn.ne.jp> <48D57245.8060606@ru.mvista.com>
In-Reply-To: <48D57245.8060606@ru.mvista.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200809271819.57244.bzolnier@gmail.com>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-Path: <bzolnier@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20647
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bzolnier@gmail.com
Precedence: bulk
X-list: linux-mips

On Saturday 20 September 2008, Sergei Shtylyov wrote:

[...]

>    But actually setting the controller's timings prior to issuing SET 
> FEATURES doesn't seem safe anyway. Bart, don't you think that we should 
> always call set_{dma|pio}_mode() AFTER ide_config_drive_speed() --
> we have no guarantee that the drive will accept the mode...

I remember some discussion about this issue in the past but currently I
don't see a reason why we shouldn't do it this way.  Care to make a patch?

Thanks,
Bart
