Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0BL6tq31726
	for linux-mips-outgoing; Fri, 11 Jan 2002 13:06:55 -0800
Received: from mailhost.taec.toshiba.com (mailhost.taec.com [209.243.128.33])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0BL6ng31723
	for <linux-mips@oss.sgi.com>; Fri, 11 Jan 2002 13:06:49 -0800
Received: from hdqmta.taec.com (hdqmta [209.243.180.59])
	by mailhost.taec.toshiba.com (8.8.8+Sun/8.8.8) with ESMTP id MAA03945;
	Fri, 11 Jan 2002 12:06:39 -0800 (PST)
Subject: Re: libtool warning on redhat 7.1 native mipsel compile
To: "H . J . Lu" <hjl@lucon.org>
Cc: linux-mips@oss.sgi.com
X-Mailer: Lotus Notes Release 5.0.3  March 21, 2000
Message-ID: <OFBDC20C8C.A135D7FF-ON88256B3E.006DCF0C@taec.com>
From: Adrian.Hulse@taec.toshiba.com
Date: Fri, 11 Jan 2002 12:08:12 -0800
X-MIMETrack: Serialize by Router on HDQMTA/TOSHIBA_TAEC(Release 5.0.8 |June 18, 2001) at
 01/11/2002 12:05:34 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


I don't know for sure just yet, the package takes a long time to compile.
The last time I compiled the package it failed to build - whether it is due
to the warnings or not I don't really know - maybe not.

 But as a result of trying to get the package to compile I came across the
"mips-1" problem and thought I'd post my findings to the list, as it seems
to have the potential to affect a lot of builds.



                                                                                              
                    "H . J . Lu"                                                              
                    <hjl@lucon.org       To:     Adrian.Hulse@taec.toshiba.com                
                    >                    cc:     linux-mips@oss.sgi.com                       
                                         Subject:     Re: libtool warning on redhat 7.1       
                    01/11/02 11:56        native mipsel compile                               
                    AM                                                                        
                                                                                              
                                                                                              




On Fri, Jan 11, 2002 at 11:53:42AM -0800, Adrian.Hulse@taec.toshiba.com
wrote:
>
> I have come across many libtool warnings when native compiling redhat 7.1
> packages on my mips board.
>
> An example warning is :
>
> *** Warning: This library needs some functionality provided by -lc
> *** I have the capability to make that library automatically link in when
> *** you link to this library. But I can only do this if you have a
> *** shared version of the library, which you do not appear to have.
>

Does that cause any problems?


H.J.
