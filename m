Received: from oss.sgi.com (localhost.localdomain [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3FEnO8d027004
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 15 Apr 2002 07:49:25 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3FEnO8o027003
	for linux-mips-outgoing; Mon, 15 Apr 2002 07:49:24 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mail.ocs.com.au (mail.ocs.com.au [203.34.97.2])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3FEnK8d026996
	for <linux-mips@oss.sgi.com>; Mon, 15 Apr 2002 07:49:21 -0700
Received: (qmail 9251 invoked from network); 15 Apr 2002 14:50:08 -0000
Received: from ocs3.intra.ocs.com.au (192.168.255.3)
  by mail.ocs.com.au with SMTP; 15 Apr 2002 14:50:08 -0000
Received: by ocs3.intra.ocs.com.au (Postfix, from userid 16331)
	id 988883000BA; Tue, 16 Apr 2002 00:50:05 +1000 (EST)
Received: from ocs3.intra.ocs.com.au (localhost [127.0.0.1])
	by ocs3.intra.ocs.com.au (Postfix) with ESMTP
	id 8AA0794; Tue, 16 Apr 2002 00:50:05 +1000 (EST)
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: "MIPS/Linux List (SGI)" <linux-mips@oss.sgi.com>
Subject: Re: Can modules be stripped? 
In-reply-to: Your message of "Mon, 15 Apr 2002 16:21:10 +0200."
             <Pine.GSO.3.96.1020415161148.19735M-100000@delta.ds2.pg.gda.pl> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 16 Apr 2002 00:50:00 +1000
Message-ID: <7082.1018882200@ocs3.intra.ocs.com.au>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 15 Apr 2002 16:21:10 +0200 (MET DST), 
"Maciej W. Rozycki" <macro@ds2.pg.gda.pl> wrote:
>On Sat, 13 Apr 2002, Keith Owens wrote:
>
>> The rules for stripping a module are "unusual".  Some symbols have to
>> be kept even if they are static, because even static symbols can be
>> exported.  The combination of strip -g to remove all debugging data
>
> Hmm, that looks weird to me.  If exporting static symbols is permitted,
>shouldn't the symbols be marked global by EXPORT_SYMBOL() then? 

Exporting static symbols has always been allowed.  Exported symbols are
the module equivalent of lazy binding, which is logically no different
from passing the address of a static symbol via a structure to a
registration function.  In either case the static symbol can be
accessed from outside the object, without being marked as global.
