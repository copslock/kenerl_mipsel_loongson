Received:  by oss.sgi.com id <S553790AbRCBQjd>;
	Fri, 2 Mar 2001 08:39:33 -0800
Received: from mailhost.taec.com ([209.243.128.33]:44934 "EHLO
        mailhost.taec.toshiba.com") by oss.sgi.com with ESMTP
	id <S553787AbRCBQjR>; Fri, 2 Mar 2001 08:39:17 -0800
Received: from hdqmta.taec.toshiba.com (hdqmta [209.243.180.59])
	by mailhost.taec.toshiba.com (8.8.8+Sun/8.8.8) with ESMTP id IAA27885;
	Fri, 2 Mar 2001 08:38:39 -0800 (PST)
Subject: Re: NFSROOT filesystem
To:     heinold@physik.tu-cottbus.de (H.Heinold)
Cc:     linux-mips@oss.sgi.com, owner-linux-mips@oss.sgi.com
X-Mailer: Lotus Notes Release 5.0.3  March 21, 2000
Message-ID: <OF4628F9A8.67E419FF-ON88256A03.005A3DC5@taec.toshiba.com>
From:   Lisa.Hsu@taec.toshiba.com
Date:   Fri, 2 Mar 2001 08:31:41 -0800
X-MIMETrack: Serialize by Router on HDQMTA/TOSHIBA_TAEC(Release 5.0.5 |September 22, 2000) at
 03/02/2001 08:37:24 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


As I understand, ash requires mush  less memory than other shells.  I am
working on an embedded system and memory is crucial to us.

Thanks,

Lisa



                                                                                                                       
                    heinold@physik.tu-                                                                                 
                    cottbus.de                To:     linux-mips@oss.sgi.com                                           
                    (H.Heinold)               cc:                                                                      
                    Sent by:                  Subject:     Re: NFSROOT filesystem                                      
                    owner-linux-mips@o                                                                                 
                    ss.sgi.com                                                                                         
                                                                                                                       
                                                                                                                       
                    03/02/01 12:17 AM                                                                                  
                                                                                                                       
                                                                                                                       




On Thu, Mar 01, 2001 at 01:30:57PM -0800, Lisa.Hsu@taec.toshiba.com wrote:
>
> Thanks to Henning for showing me where to get the big-endian compiled
> packages and it works.   Now, I need big-endian compiled "ash".
> Is anybody know where I can get it?
>
> Thanks,
>
> Lisa
>

Hm why you need the ash? You can give the kernel the follwing via the
commandoline init=/bin/bash.
--


Henning Heinold
