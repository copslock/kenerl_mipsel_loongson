Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7FHvGP20700
	for linux-mips-outgoing; Wed, 15 Aug 2001 10:57:16 -0700
Received: from mail.foobazco.org (snowman.foobazco.org [198.144.194.230])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7FHv6j20659;
	Wed, 15 Aug 2001 10:57:06 -0700
Received: by mail.foobazco.org (Postfix, from userid 1014)
	id DFAD23E90; Wed, 15 Aug 2001 10:44:35 -0700 (PDT)
Date: Wed, 15 Aug 2001 10:44:35 -0700
From: Keith M Wesolowski <wesolows@foobazco.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: "Gleb O. Raiko" <raiko@niisi.msk.ru>, Ralf Baechle <ralf@oss.sgi.com>,
   Harald Koerfgen <hkoerfg@web.de>, linux-mips@fnet.fr,
   linux-mips@oss.sgi.com
Subject: Re: [patch] linux 2.4.5: Export mips_machtype
Message-ID: <20010815104435.A8370@foobazco.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1010814193527.5426C-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.3.18i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Aug 14, 2001 at 07:43:23PM +0200, Maciej W. Rozycki wrote:

>  How do you set up mips_machtype on your system in the first place?  At
> kernel_entry the code does not know what machine it's running on anyway,
> so it has to set mips_machtype based on a detection algorithm. 

Of course.  I published a patch and some documentation a long time ago
for doing just this.  I don't think anyone ever even read any of it; I
received no comments.  In any case it's currently used in my tree for
O2 and although I know it could be better it seems to work rather
well.

-- 
Keith M Wesolowski <wesolows@foobazco.org> http://foobazco.org/~wesolows
------(( Project Foobazco Coordinator and Network Administrator ))------
 	"There is no such song as 'Acid Acid Acid' by 'The Acid Heads'
	 but there might as well be." --jwz
