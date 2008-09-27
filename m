Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 Sep 2008 18:30:06 +0100 (BST)
Received: from fg-out-1718.google.com ([72.14.220.156]:20859 "EHLO
	fg-out-1718.google.com") by ftp.linux-mips.org with ESMTP
	id S20132334AbYI0R27 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 27 Sep 2008 18:28:59 +0100
Received: by fg-out-1718.google.com with SMTP id d23so971313fga.32
        for <linux-mips@linux-mips.org>; Sat, 27 Sep 2008 10:28:57 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=Z09QEGeRv0edRxXacUDszzkh9z9gG24YiWqIlvBD64w=;
        b=H2PmS4R1ILS6ChfxOnW9FQltkW5UDSZvcWETzcqXWHlH9qgJBADOa74t909M49KNCt
         c3784uNRbBJ1Qv1GnA83mAajXY2p90dUJaqzCuX9STvjxSz02vr32MqsPb3fYrcKMhft
         kj1rZPyI6NQnYn2pJuCvysleBIhek4BJ6crO8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=UBUvmYAiu9jd62N4CPSX5bOeN4mPyp5C80xQOtHJ0Tc5EoWXn62/hUdCbOwy78emr9
         +wO5wgTGkXnwkgFje9bp+ovNGSjJyxcIC+kGTQTUPvXFhBWBKLP/pRLZQl7Obd4Qy8io
         70Rb+1MgeRdm+UnLumPQLGdxh3TAKU54O52Sw=
Received: by 10.103.249.19 with SMTP id b19mr2075411mus.50.1222536536920;
        Sat, 27 Sep 2008 10:28:56 -0700 (PDT)
Received: from ?192.168.123.7? (chello089077041080.chello.pl [89.77.41.80])
        by mx.google.com with ESMTPS id y37sm561478mug.13.2008.09.27.10.28.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 27 Sep 2008 10:28:55 -0700 (PDT)
From:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] Swarm: Fix crash due to missing initialization
Date:	Sat, 27 Sep 2008 18:30:23 +0200
User-Agent: KMail/1.9.10
Cc:	linux-ide@vger.kernel.org, linux-mips@linux-mips.org
References: <20080921204716.GA29927@linux-mips.org>
In-Reply-To: <20080921204716.GA29927@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200809271830.23240.bzolnier@gmail.com>
Return-Path: <bzolnier@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20650
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bzolnier@gmail.com
Precedence: bulk
X-list: linux-mips

On Sunday 21 September 2008, Ralf Baechle wrote:
> If things are just right this will result in the hws[0]->parent being
> passed to ide_host_add() being non-zero and an ooops a little later.
> 
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

thanks, applied
