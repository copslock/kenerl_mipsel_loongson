Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Jun 2008 12:02:36 +0100 (BST)
Received: from p549F5460.dip.t-dialin.net ([84.159.84.96]:8578 "EHLO
	p549F5460.dip.t-dialin.net") by ftp.linux-mips.org with ESMTP
	id S20031462AbYFCLCd (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 3 Jun 2008 12:02:33 +0100
Received: from yw-out-1718.google.com ([74.125.46.157]:24494 "EHLO
	yw-out-1718.google.com") by lappi.linux-mips.net with ESMTP
	id S527144AbYFCIj3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 3 Jun 2008 10:39:29 +0200
Received: by yw-out-1718.google.com with SMTP id 9so604272ywk.24
        for <linux-mips@linux-mips.org>; Tue, 03 Jun 2008 01:38:19 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=wpE3Jak1lMhMl5hLgogLX2umKsR/sorZKVk4iX9Sk5s=;
        b=f47c5TKoUK2ueTGtf1LE+VL3JbJjOYVmTh0pWIf/mVsSZSpTSmu6XioIK6rxN9C0cciTRAhZ9geXtB54GiGfpYwknRcZVlmxB829u88t7WHjApXn19iM1hcfxOYRiQ+en23UMLBKzilxBeHymX+G+xZ4AJ80NAA8NdWW44FWwFw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gaEnFOqGsIDnXt+JaI3dhD6V0rJNTeGic2wNDceMZl2IyVLt9M9dM6YvLCnkt7lMyNv5I1B1z3wtXPYJvGMWsAFeQGVaMRANpzsI6wzHcXVyatv7QCegMoqHLLXR/dIUKdD5HdwX/BdM5TiYSetdFjU/0ju6ZZKIlmKlvEMZ9bQ=
Received: by 10.151.158.2 with SMTP id k2mr583176ybo.70.1212482299775;
        Tue, 03 Jun 2008 01:38:19 -0700 (PDT)
Received: by 10.150.140.6 with HTTP; Tue, 3 Jun 2008 01:38:19 -0700 (PDT)
Message-ID: <90edad820806030138x7837f69exbf3362470ca0021c@mail.gmail.com>
Date:	Tue, 3 Jun 2008 11:38:19 +0300
From:	"Dmitri Vorobiev" <dmitri.vorobiev@gmail.com>
To:	"Thomas Bogendoerfer" <tsbogend@alpha.franken.de>
Subject: Re: Malta build errors with 2.6.26-rc1
Cc:	"Martin Michlmayr" <tbm@cyrius.com>, linux-mips@linux-mips.org,
	ralf@linux-mips.org
In-Reply-To: <90edad820806020840m2e9f5588x81f8c387aef23c6c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20080512163107.GA19052@deprecation.cyrius.com>
	 <90edad820805121246o328d1cdaide88594ce9d328b7@mail.gmail.com>
	 <20080528071240.GB10393@deprecation.cyrius.com>
	 <20080528085033.GA6250@alpha.franken.de>
	 <20080528151025.GA15325@deprecation.cyrius.com>
	 <20080529200506.GA27783@alpha.franken.de>
	 <90edad820806020840m2e9f5588x81f8c387aef23c6c@mail.gmail.com>
Return-Path: <dmitri.vorobiev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19397
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

>
> So, you might want to add
>
> Tested-by: Dmitri Vorobiev <dmtiri.vorobiev@movial.fi>

Ouch, I made a typo. Corrected version:

Tested-by: Dmitri Vorobiev <dmitri.vorobiev@movial.fi>

P.S. Sorry for a duplicate post, but we're currently having some
problems with email at linux-mips.org...

Dmitri

>
