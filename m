Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Jan 2009 16:33:10 +0000 (GMT)
Received: from accolon.hansenpartnership.com ([76.243.235.52]:17856 "EHLO
	accolon.hansenpartnership.com") by ftp.linux-mips.org with ESMTP
	id S24208002AbZABQdI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 2 Jan 2009 16:33:08 +0000
Received: from localhost (localhost [127.0.0.1])
	by accolon.hansenpartnership.com (Postfix) with ESMTP id 569D481DC;
	Fri,  2 Jan 2009 10:33:01 -0600 (CST)
Received: from accolon.hansenpartnership.com ([127.0.0.1])
	by localhost (redscar.int.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KorKJGzqVqKG; Fri,  2 Jan 2009 10:33:00 -0600 (CST)
Received: from [153.66.150.222] (mulgrave-w.int.hansenpartnership.com [153.66.150.222])
	by accolon.hansenpartnership.com (Postfix) with ESMTP id 2D0C97F63;
	Fri,  2 Jan 2009 10:33:00 -0600 (CST)
Subject: Re: [PATCH] SCSI: fix the return type of the remove() method in
	sgiwd93.c
From:	James Bottomley <James.Bottomley@HansenPartnership.com>
To:	Kay Sievers <kay.sievers@vrfy.org>
Cc:	Vorobiev Dmitri <dmitri.vorobiev@movial.fi>,
	linux-scsi@vger.kernel.org, linux-mips@linux-mips.org,
	Greg KH <greg@kroah.com>
In-Reply-To: <ac3eb2510901020831q5c17f38cr65fa8cb9f49bb077@mail.gmail.com>
References: <1227140357-29921-1-git-send-email-dmitri.vorobiev@movial.fi>
	 <1228330800.5551.58.camel@localhost.localdomain>
	 <ac3eb2510812031229l51912169o3e96346ed51c48f0@mail.gmail.com>
	 <1228337529.5551.72.camel@localhost.localdomain>
	 <ac3eb2510812031259v1a4ebe25tc841daaa2fe5a722@mail.gmail.com>
	 <1228338142.5551.77.camel@localhost.localdomain>
	 <ac3eb2510812031328x38559660rcc13db195e01ea15@mail.gmail.com>
	 <1228340025.5551.87.camel@localhost.localdomain>
	 <1228340496.6977.19.camel@nga>
	 <1230913510.3304.2.camel@localhost.localdomain>
	 <ac3eb2510901020831q5c17f38cr65fa8cb9f49bb077@mail.gmail.com>
Content-Type: text/plain
Date:	Fri, 02 Jan 2009 10:32:59 -0600
Message-Id: <1230913979.3304.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.22.3.1 (2.22.3.1-1.fc9) 
Content-Transfer-Encoding: 7bit
Return-Path: <James.Bottomley@HansenPartnership.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21681
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: James.Bottomley@HansenPartnership.com
Precedence: bulk
X-list: linux-mips

On Fri, 2009-01-02 at 17:31 +0100, Kay Sievers wrote:
> On Fri, Jan 2, 2009 at 17:25, James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> > Sorry, dropped the ball a bit on this.  I've attached the updated
> > version: it copes with the legacy 20 character copy in the ioctl by
> > brute force and also adds several other dev->bus_id -> dev_name(dev)
> > conversions.
> 
> Very nice. Thanks!
> 
> Will you get that in 2.6.29 through your SCSI tree, or should the copy
> in Greg's tree be updated?

I'll send it with my next set.

James
