Received:  by oss.sgi.com id <S553746AbQJRO7l>;
	Wed, 18 Oct 2000 07:59:41 -0700
Received: from ppp0.ocs.com.au ([203.34.97.3]:58635 "HELO mail.ocs.com.au")
	by oss.sgi.com with SMTP id <S553736AbQJRO7X>;
	Wed, 18 Oct 2000 07:59:23 -0700
Received: (qmail 26493 invoked from network); 18 Oct 2000 14:59:17 -0000
Received: from ocs3.ocs-net (192.168.255.3)
  by mail.ocs.com.au with SMTP; 18 Oct 2000 14:59:17 -0000
X-Mailer: exmh version 2.1.1 10/15/1999
From:   Keith Owens <kaos@melbourne.sgi.com>
To:     Albert Aumenta <aumenta@sgibos.boston.sgi.com>
cc:     linux-mips@oss.sgi.com
Subject: Re: network speeds 
In-reply-to: Your message of "Wed, 18 Oct 2000 10:41:34 EDT."
             <39EDB69E.2C89D8C4@boston.sgi.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Thu, 19 Oct 2000 01:59:15 +1100
Message-ID: <4838.971881155@ocs3.ocs-net>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, 18 Oct 2000 10:41:34 -0400, 
Albert Aumenta <aumenta@sgibos.boston.sgi.com> wrote:
>I have the need to confirm the speed at which the network interface is
>running at on a customer site on a 1200 . I am assuming the answer is in
>/proc
>but have been unable to find it.

Sore point, linux network device drivers do not export network
interface speeds.  Your best option is mii-diag from
http://www.scyld.com/diag/index.html.
