Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 May 2003 19:34:14 +0100 (BST)
Received: from bay1-f135.bay1.hotmail.com ([IPv6:::ffff:65.54.245.135]:59154
	"EHLO hotmail.com") by linux-mips.org with ESMTP
	id <S8225255AbTEISeM>; Fri, 9 May 2003 19:34:12 +0100
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Fri, 9 May 2003 11:34:03 -0700
Received: from 4.35.224.219 by by1fd.bay1.hotmail.msn.com with HTTP;
	Fri, 09 May 2003 18:34:03 GMT
X-Originating-IP: [4.35.224.219]
X-Originating-Email: [michaelanburaj@hotmail.com]
From: "Michael Anburaj" <michaelanburaj@hotmail.com>
To: jbglaw@lug-owl.de, linux-mips@linux-mips.org
Subject: Re: Linux for MIPS Atlas 4Kc board
Date: Fri, 09 May 2003 11:34:03 -0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY1-F13582h4PPyd7D00009472@hotmail.com>
X-OriginalArrivalTime: 09 May 2003 18:34:03.0466 (UTC) FILETIME=[90DABAA0:01C31659]
Return-Path: <michaelanburaj@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2326
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: michaelanburaj@hotmail.com
Precedence: bulk
X-list: linux-mips

Almost there...

Looking up port of RPC 100003/2 on 4.42.102.7
portmap: server 4.42.102.7 not responding, timed out
Root-NFS: Unable to get nfsd port number from server, using default
Looking up port of RPC 100005/1 on 4.42.102.7
portmap: server 4.42.102.7 not responding, timed out
Root-NFS: Unable to get mountd port number from server, using default
mount: server 4.42.102.7 not responding, timed out
Root-NFS: Server returned error -5 while mounting /export/RedHat7.1
VFS: Unable to mount root fs via NFS, trying floppy.
VFS: Cannot open root device "" or 02:00
Please append a correct "root=" boot option
Kernel panic: VFS: Unable to mount root fs on 02:00

Where can I find the explanation for these nfs error codes? Why is it 
returning -5?


Clipping from /var/log/messages:

May  9 08:07:50 localhost exportfs[2460]: No 'sync' or 'async' option 
specified
for export "*:/export/RedHat7.1".   Assuming default behaviour ('sync').   
NOTE: this default has changed from previous versions
May  9 08:07:50 localhost exportfs: exportfs: No 'sync' or 'async' option 
specified for export "*:/export/RedHat7.1".
May  9 08:07:50 localhost exportfs:   Assuming default behaviour ('sync').
May  9 08:07:50 localhost exportfs:   NOTE: this default has changed from 
previous versions


Is 'sync' ok?

--Mike.

_________________________________________________________________
Tired of spam? Get advanced junk mail protection with MSN 8. 
http://join.msn.com/?page=features/junkmail
