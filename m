Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6AJjRO04788
	for linux-mips-outgoing; Tue, 10 Jul 2001 12:45:27 -0700
Received: from web11906.mail.yahoo.com (web11906.mail.yahoo.com [216.136.172.190])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6AJjQV04775
	for <linux-mips@oss.sgi.com>; Tue, 10 Jul 2001 12:45:26 -0700
Message-ID: <20010710194526.44019.qmail@web11906.mail.yahoo.com>
Received: from [209.243.184.191] by web11906.mail.yahoo.com via HTTP; Tue, 10 Jul 2001 12:45:26 PDT
Date: Tue, 10 Jul 2001 12:45:26 -0700 (PDT)
From: Wayne Gowcher <wgowcher@yahoo.com>
Subject: USB OHCI on 2.4.2 kernel using r4k processor
To: linux-mips@oss.sgi.com
In-Reply-To: <20010604235443.A27996@bacchus.dhis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Dear All,

Has anyone got USB OHCI running on a 2.4.2 kernel with
a mips r4k processor ?

I have successfully used the above with a r3k mips
processor but now after porting the same base code to
a r4k processor the kernel throws an OOPS.

I believe the problem may lay with the writeback cache
because when I disable the d cache on the r4k 2.4.2
kernel USB works fine !

I did some digging around and noted that the working
aic7xxx driver I have on the 2.4.2 r4k makes use of
pci_map_single to handle cache flushing ( ??? please
correct me if I am wrong ) and that this type of code
doesn't make it into the usb code until 2.4.4 of the
sgi linux kernel.

Does anyone have a "back patch" to apply to the 2.4.2
usb code ?

If not I am thinking of attempting this myself and
would welcome any comments / advice about doing this

TIA

Wayne



__________________________________________________
Do You Yahoo!?
Get personalized email addresses from Yahoo! Mail
http://personal.mail.yahoo.com/
