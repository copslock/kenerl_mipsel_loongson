Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6M1XQd27107
	for linux-mips-outgoing; Sat, 21 Jul 2001 18:33:26 -0700
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6M1XOV27104
	for <linux-mips@oss.sgi.com>; Sat, 21 Jul 2001 18:33:25 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 04D007D9; Sun, 22 Jul 2001 03:33:22 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 3FB8A43E8; Sun, 22 Jul 2001 03:30:38 +0200 (CEST)
Date: Sun, 22 Jul 2001 03:30:38 +0200
From: Florian Lohoff <flo@rfc822.org>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: linux-mips@oss.sgi.com
Subject: Re: I2 R10K status?
Message-ID: <20010722033038.B10591@paradigm.rfc822.org>
References: <200107201749.KAA05236@saturn.mikemac.com> <20010720220155.D16278@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20010720220155.D16278@rembrandt.csv.ica.uni-stuttgart.de>; from ica2_ts@csv.ica.uni-stuttgart.de on Fri, Jul 20, 2001 at 10:01:55PM +0200
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Jul 20, 2001 at 10:01:55PM +0200, Thiemo Seufer wrote:
> processes crash due to unaligned access/illegal instruction in
> kernel space. The serial console drops characters on high
> throughput.

This is true for all sgis IMHO - I have seen this before on the
Indy and Indigo2 - This is a bug in the sgiserial.c - I have tried
to find it before but havent been successfull. Another bug lets
the serial to freeze completely which prevents serial console
machines from reboot as the and print to the console blocks.

This has been fixed somewhere in the 2.4 area.

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
