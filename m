Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3PKJ6T15728
	for linux-mips-outgoing; Wed, 25 Apr 2001 13:19:06 -0700
Received: from gandalf.physik.uni-konstanz.de (gandalf.physik.uni-konstanz.de [134.34.144.69])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3PKJ5M15725
	for <linux-mips@oss.sgi.com>; Wed, 25 Apr 2001 13:19:06 -0700
Received: from bilbo.physik.uni-konstanz.de [134.34.144.81] (8)
	by gandalf.physik.uni-konstanz.de with esmtp (Exim 3.12 #1 (Debian))
	id 14sVkb-0003jG-00; Wed, 25 Apr 2001 22:19:01 +0200
Received: from agx by bilbo.physik.uni-konstanz.de with local (Exim 3.12 #1 (Debian))
	id 14sVkb-00044L-00; Wed, 25 Apr 2001 22:19:01 +0200
Date: Wed, 25 Apr 2001 22:19:01 +0200
From: Guido Guenther <guido.guenther@gmx.net>
To: "George Gensure,,," <werkt@csh.rit.edu>
Cc: linux-mips@oss.sgi.com
Subject: Re: /dev/psaux
Message-ID: <20010425221901.A15634@bilbo.physik.uni-konstanz.de>
Mail-Followup-To: "George Gensure,,," <werkt@csh.rit.edu>,
	linux-mips@oss.sgi.com
References: <3AE70E1E.6050005@csh.rit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AE70E1E.6050005@csh.rit.edu>; from werkt@csh.rit.edu on Wed, Apr 25, 2001 at 01:49:18PM -0400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Apr 25, 2001 at 01:49:18PM -0400, George Gensure,,, wrote:
> Can someone give me some valid major and minor numbers for a ps/2 mouse 
> on an Indy?
ls -l /dev/psaux 
crw-------    1 root     root      10,   1 Jul  5  2000 /dev/psaux
This is not mips specific.
 -- Guido
