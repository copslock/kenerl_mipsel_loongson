Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Nov 2007 22:27:01 +0000 (GMT)
Received: from mail.zeugmasystems.com ([70.79.96.174]:1967 "EHLO
	zeugmasystems.com") by ftp.linux-mips.org with ESMTP
	id S20034930AbXKSW0w convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 19 Nov 2007 22:26:52 +0000
x-mimeole: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: "exportfs -a" -> stale NFS filehandle
Date:	Mon, 19 Nov 2007 14:26:24 -0800
Message-ID: <DDFD17CC94A9BD49A82147DDF7D545C54DCE34@exchange.ZeugmaSystems.local>
In-Reply-To: <DDFD17CC94A9BD49A82147DDF7D545C54DC8F6@exchange.ZeugmaSystems.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: "exportfs -a" -> stale NFS filehandle
Thread-Index: AcgnwCCtCdy5qIVVTMaI/zfLoW8HSAAAB8CwAM5jgNA=
From:	"Kaz Kylheku" <kaz@zeugmasystems.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Cc:	<linux-mips@linux-mips.org>
Return-Path: <kaz@zeugmasystems.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17536
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kaz@zeugmasystems.com
Precedence: bulk
X-list: linux-mips

Last week, I wrote:
> Ralf Baechle wrote:
>> On Thu, Nov 15, 2007 at 11:26:06AM -0800, Kaz Kylheku wrote:
>> 
>>> After backing out the nfsutils patch, the diskless node does boot.
>>> 
>>> However, the original "exportfs -a" problem comes back!
>>> 
>>> So this problem is not resolved simply by using the correct compat
>>> routine; it's deeper. 
>>> 
>>> Sigh.
>> 
>> Thanks for testing anyway!
> 
> I'm continuing to dig into the problem.
> 
> The export logic doesn't even go through nfsctl() anyway,
> which is why I
> originally hadn't even suspected that syscall.
> 
> The nfsexport() function in nfsutils first tries opening
> "/proc/net/rpc/nfsd.fh./channel". If that works, it uses that, via a
> text-based protocol. Only if that interface doesn't exist does it fall
> back on the nfsctl(NFSCTL_EXPORT, ...) interface.

Basically, the export table is being mismanaged. Simply restarting NFS
(service nfs restart) will cause this problem to appear.

When the system is first booted up and NFS is started in runlevel 3 by
the nfs init script, the exportfs command correctly populates the export
table based on the /etc/exports file.

However, after that, further management of the export table fails. Doing
an "exportfs -a" clears it out. You can see the table in
/proc/net/rpc/nfsd.export/content. Before the operation, the table has
valid entries. After the operation, it simply clears out and stays
empty. 

This is in spite of the fact that the exportfs command seems to be doing
exactly what it did the first time when NFS was successfully started
(i.e. it's a kernel problem; user space is doing the same thing that
worked before).

I verified that by turning on various additional tracing with sysctl
(sunrpc.nfsd_debug), and I added some extra traces to the function that
adds exports (svc_export_parse) to view the messages that are coming
down the nfsd.fh/channel pipe in /proc.

So the summary is that this problem appears to be some kind of
corruption of the RPC cache for exports.

I did see the kernel crash with an alignment exception once upon
reproducing the problem, but haven't been able to repro that.
