Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3O1eLw23236
	for linux-mips-outgoing; Mon, 23 Apr 2001 18:40:21 -0700
Received: from mail.foobazco.org (snowman.foobazco.org [198.144.194.230])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3O1eLM23233
	for <linux-mips@oss.sgi.com>; Mon, 23 Apr 2001 18:40:21 -0700
Received: by mail.foobazco.org (Postfix, from userid 1014)
	id 83AD5F1A9; Mon, 23 Apr 2001 18:39:37 -0700 (PDT)
Date: Mon, 23 Apr 2001 18:39:37 -0700
From: Keith M Wesolowski <wesolows@foobazco.org>
To: "George Gensure,,," <werkt@csh.rit.edu>
Cc: linux-mips@oss.sgi.com
Subject: Re: /dev/psaux
Message-ID: <20010423183937.A4473@foobazco.org>
References: <3AE4D692.7030904@csh.rit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AE4D692.7030904@csh.rit.edu>; from werkt@csh.rit.edu on Mon, Apr 23, 2001 at 09:27:46PM -0400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Apr 23, 2001 at 09:27:46PM -0400, George Gensure,,, wrote:

> How can I get the device entry for the ps/2 mouse in the dev table 
> without recompiling my 2.4.3 kernel.  I KNOW there has to be a way.

There is a way.  Recompile your kernel and include ps2 mouse support.

Of course, you should make sure the device mode exists and is
accessible first...

-- 
Keith M Wesolowski <wesolows@foobazco.org> http://foobazco.org/~wesolows
------(( Project Foobazco Coordinator and Network Administrator ))------
	"Nothing motivates a man more than to see his boss put
	 in an honest day's work." -- The fortune file
