Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Jan 2009 16:31:11 +0000 (GMT)
Received: from mail-ew0-f21.google.com ([209.85.219.21]:3494 "EHLO
	mail-ew0-f21.google.com") by ftp.linux-mips.org with ESMTP
	id S24208002AbZABQbI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 2 Jan 2009 16:31:08 +0000
Received: by ewy14 with SMTP id 14so6778941ewy.0
        for <linux-mips@linux-mips.org>; Fri, 02 Jan 2009 08:31:02 -0800 (PST)
Received: by 10.210.29.11 with SMTP id c11mr4077231ebc.29.1230913862688;
        Fri, 02 Jan 2009 08:31:02 -0800 (PST)
Received: by 10.210.127.8 with HTTP; Fri, 2 Jan 2009 08:31:02 -0800 (PST)
Message-ID: <ac3eb2510901020831q5c17f38cr65fa8cb9f49bb077@mail.gmail.com>
Date:	Fri, 2 Jan 2009 17:31:02 +0100
From:	"Kay Sievers" <kay.sievers@vrfy.org>
To:	"James Bottomley" <James.Bottomley@hansenpartnership.com>
Subject: Re: [PATCH] SCSI: fix the return type of the remove() method in sgiwd93.c
Cc:	"Vorobiev Dmitri" <dmitri.vorobiev@movial.fi>,
	linux-scsi@vger.kernel.org, linux-mips@linux-mips.org,
	"Greg KH" <greg@kroah.com>
In-Reply-To: <1230913510.3304.2.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
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
Return-Path: <kay.sievers@vrfy.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21680
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kay.sievers@vrfy.org
Precedence: bulk
X-list: linux-mips

On Fri, Jan 2, 2009 at 17:25, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
> Sorry, dropped the ball a bit on this.  I've attached the updated
> version: it copes with the legacy 20 character copy in the ioctl by
> brute force and also adds several other dev->bus_id -> dev_name(dev)
> conversions.

Very nice. Thanks!

Will you get that in 2.6.29 through your SCSI tree, or should the copy
in Greg's tree be updated?

Thanks,
Kay
