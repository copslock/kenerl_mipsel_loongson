Received:  by oss.sgi.com id <S42290AbQEXNtD>;
	Wed, 24 May 2000 06:49:03 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:46351 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42277AbQEXNs5>;
	Wed, 24 May 2000 06:48:57 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id GAA24439; Wed, 24 May 2000 06:44:04 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id GAA27276
	for linux-list;
	Wed, 24 May 2000 06:41:00 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id GAA86682
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 24 May 2000 06:40:59 -0700 (PDT)
	mail_from (agx@bert.physik.uni-konstanz.de)
Received: from gandalf.physik.uni-konstanz.de (gandalf.physik.uni-konstanz.de [134.34.144.30]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id GAA05578
	for <linux@cthulhu.engr.sgi.com>; Wed, 24 May 2000 06:40:58 -0700 (PDT)
	mail_from (agx@bert.physik.uni-konstanz.de)
Received: from bert.physik.uni-konstanz.de [134.34.144.20] 
	by gandalf.physik.uni-konstanz.de with smtp (Exim 2.05 #1 (Debian))
	id 12ubP9-0008MU-00; Wed, 24 May 2000 15:40:59 +0200
Received: by bert.physik.uni-konstanz.de (sSMTP sendmail emulation); Wed, 24 May 2000 15:39:43 +0200
Date:   Wed, 24 May 2000 15:39:43 +0200
From:   Guido Guenther <agx@bert.physik.uni-konstanz.de>
To:     Mitja Bezget <gw@sers.s-sers.mb.edus.si>
Cc:     linux@cthulhu.engr.sgi.com
Subject: Re: Binary XFree
Message-ID: <20000524153943.B3802@bert.physik.uni-konstanz.de>
Mail-Followup-To: Guido Guenther <guido.guenther@uni-konstanz.de>,
	Mitja Bezget <gw@sers.s-sers.mb.edus.si>,
	linux@cthulhu.engr.sgi.com
References: <Pine.LNX.3.95.1000524131606.8181B-100000@sers.s-sers.mb.edus.si>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.1.9i
In-Reply-To: <Pine.LNX.3.95.1000524131606.8181B-100000@sers.s-sers.mb.edus.si>; from gw@sers.s-sers.mb.edus.si on Wed, May 24, 2000 at 01:19:45PM +0200
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

No problem here. Should be a problem with you local setup. Can you
"touch /var/log/XFree86.0.log" as root?
 -- Guido

On Wed, May 24, 2000 at 01:19:45PM +0200, Mitja Bezget wrote:
> 
> Hey!
> 
> I downloaded the binarys and installed successfuly.. But the 
> server still wouldn't run.. it displays a senseless message:
> Couldn't open log file "/var/log/XFree86.0.log" 
> 
> although it is run as root and the directory exists.
> any ideas? thanks!
> 
> cya
> Mitja
> 
> 
> 

-- 
GPG-Public Key: http://honk.physik.uni-konstanz.de/~agx/guenther.gpg.asc
