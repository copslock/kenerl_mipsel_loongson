Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f78DttC02020
	for linux-mips-outgoing; Wed, 8 Aug 2001 06:55:55 -0700
Received: from cygnus.com (runyon.cygnus.com [205.180.230.5])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f78DtsV02014
	for <linux-mips@oss.sgi.com>; Wed, 8 Aug 2001 06:55:54 -0700
Received: from localhost.localdomain (taarna.cygnus.com [205.180.230.102])
	by runyon.cygnus.com (8.8.7-cygnus/8.8.7) with ESMTP id GAA18627;
	Wed, 8 Aug 2001 06:53:06 -0700 (PDT)
Subject: Re: PATCH: Clean up Linux/mips.
From: Eric Christopher <echristo@redhat.com>
To: "H . J . Lu" <hjl@lucon.org>
Cc: gcc-patches@gcc.gnu.org, linux-mips@oss.sgi.com
In-Reply-To: <20010807084236.A5550@lucon.org>
References: <20010807084236.A5550@lucon.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12 (Preview Release)
Date: 08 Aug 2001 14:51:45 +0100
Message-Id: <997278707.1290.41.camel@ghostwheel.cygnus.com>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ok, with one question:

> 	* config/mips/little.h: New. Generic little endian mips
> 	targets.

Did you convert the other *el ports to use this?  It doesn't look like
it.

-eric

-- 
Look out behind you!
