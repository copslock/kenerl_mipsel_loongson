Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g27BxXD23189
	for linux-mips-outgoing; Thu, 7 Mar 2002 03:59:33 -0800
Received: from oval.algor.co.uk (root@oval.algor.co.uk [62.254.210.250])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g27BxT923185
	for <linux-mips@oss.sgi.com>; Thu, 7 Mar 2002 03:59:30 -0800
Received: from mudchute.algor.co.uk (dom@mudchute.algor.co.uk [62.254.210.251])
	by oval.algor.co.uk (8.11.6/8.10.1) with ESMTP id g27AxO208314;
	Thu, 7 Mar 2002 10:59:24 GMT
Received: (from dom@localhost)
	by mudchute.algor.co.uk (8.8.5/8.8.5) id KAA21103;
	Thu, 7 Mar 2002 10:59:23 GMT
Date: Thu, 7 Mar 2002 10:59:23 GMT
Message-Id: <200203071059.KAA21103@mudchute.algor.co.uk>
From: Dominic Sweetman <dom@algor.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: Marc Karasek <marc_karasek@ivivity.com>
Cc: Linux MIPS <linux-mips@oss.sgi.com>
Subject: Re: Questions?
In-Reply-To: <1015435541.3714.33.camel@MCK_Linux>
References: <1015435541.3714.33.camel@MCK_Linux>
X-Mailer: VM 6.34 under 19.16 "Lille" XEmacs Lucid
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Marc Karasek (marc_karasek@ivivity.com) writes:

> What endianess have you chosen for your project and why? 

The MIPS world is irredemiably split, and the pull between SGI
(always big-endian, M68000 heritage and Sun compatibility) and Linux'
tendency to see the x86 as the universe has left Linux/MIPS split too.

As software tool and prototyping board supplier, we just know that
everything we do has to work either way.

If you can change that, it would be great! :-)

--
Dominic Sweetman, 
Algorithmics Ltd
The Fruit Farm, Ely Road, Chittering, CAMBS CB5 9PH, ENGLAND
phone: +44 1223 706200 / fax: +44 1223 706250 / direct: +44 1223 706205
http://www.algor.co.uk
