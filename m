Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Nov 2007 23:20:20 +0000 (GMT)
Received: from mail.zeugmasystems.com ([192.139.122.66]:51862 "EHLO
	zeugmasystems.com") by ftp.linux-mips.org with ESMTP
	id S20031007AbXKNXUL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 14 Nov 2007 23:20:11 +0000
x-mimeole: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: "exportfs -a" -> stale NFS filehandle
Date:	Wed, 14 Nov 2007 15:19:43 -0800
Message-ID: <DDFD17CC94A9BD49A82147DDF7D545C547AF5B@exchange.ZeugmaSystems.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: "exportfs -a" -> stale NFS filehandle
Thread-Index: AcgnFNbW97dDhBWkQhSAn9o02emXvQ==
From:	"Kaz Kylheku" <kaz@zeugmasystems.com>
To:	<linux-mips@linux-mips.org>
Return-Path: <kaz@zeugmasystems.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17504
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kaz@zeugmasystems.com
Precedence: bulk
X-list: linux-mips

Hi all,

I have an NFS problem on a multi-node MIPS system running kernel
2.6.17.7. NFS utils is 1.1.0. ABI is n32.

One node (call it primary) exports a directory which is mounted by
several others (the secondaries) as their root filesystem.

If I run "exportfs -a" on the primary, the secondary nodes lose their
root filesystem and so everything stops working.

I turned on all NFS debugging on a secondary node (sysctl -w
sunrpc.nfs_debug=65535). What is happening is that NFS operations
suddenly start returning error -151 (stale NFS filehandle).

I don't see exportfs causing this problem on other systems. If I run
"exportfs -a" on a big NFS server (Fedora Core 5, i686) which has lots
of diskless clients, nothing bad happens. (And some of those diskless
clients are MIPS systems just like this one!)

I'm pretty sure that exportfs -a shouldn't screw up the existing mounted
clients.

Could there be some ABI problem that corrupts up the effect of the
re-exporting operation on the server?

(This issure reproduces always. Something which reproduces rarely is a
kernel crash on a secondary node, inside the nfsd process, also
apparently in response to the "exportfs -a". I don't yet have enough
information about that one, such as a call trace, etc. That one I can
drill into, if I have a program counter and call stack.)
