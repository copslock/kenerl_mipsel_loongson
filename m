Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3H3lRp18628
	for linux-mips-outgoing; Mon, 16 Apr 2001 20:47:27 -0700
Received: from mail.foobazco.org (snowman.foobazco.org [198.144.194.230])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3H3lQM18625
	for <linux-mips@oss.sgi.com>; Mon, 16 Apr 2001 20:47:26 -0700
Received: from galt.foobazco.org (galt.foobazco.org [198.144.194.227])
	by mail.foobazco.org (Postfix) with ESMTP
	id 14A74F1A4; Mon, 16 Apr 2001 20:46:50 -0700 (PDT)
Received: by galt.foobazco.org (Postfix, from userid 1014)
	id E9A121F42A; Mon, 16 Apr 2001 08:07:24 -0700 (PDT)
Date: Mon, 16 Apr 2001 08:07:24 -0700
From: Keith M Wesolowski <wesolows@foobazco.org>
To: Shay Deloya <shay@jungo.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Ioctl size mask
Message-ID: <20010416080724.A12989@foobazco.org>
References: <01041612582600.25043@athena.home.krftech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01041612582600.25043@athena.home.krftech.com>; from shay@jungo.com on Mon, Apr 16, 2001 at 01:44:42PM +0300
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Apr 16, 2001 at 01:44:42PM +0300, Shay Deloya wrote:

> On asm-mips/ioctl.h , there is a mask on the size transfered to the ioctl , 
> e.g. : when implementing an ioctl that handles IO , the max size the 
> supported in mips is 0xff  as defined in the code below: 
...
> Does anyone know the reason for this masking and limit  ? 

Breakage.  This has recently been fixed at least in cvs; update your
kernel.

-- 
Keith M Wesolowski <wesolows@foobazco.org> http://foobazco.org/~wesolows
------(( Project Foobazco Coordinator and Network Administrator ))------
	"Nothing motivates a man more than to see his boss put
	 in an honest day's work." -- The fortune file
