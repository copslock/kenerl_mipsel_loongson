Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id UAA97097 for <linux-archive@neteng.engr.sgi.com>; Thu, 22 Apr 1999 20:10:16 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id UAA09670
	for linux-list;
	Thu, 22 Apr 1999 20:07:55 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id UAA10206
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 22 Apr 1999 20:07:52 -0700 (PDT)
	mail_from (clepple@foo.tho.org)
Received: from foo.tho.org (pr250.pheasantrun.net [208.140.225.250]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id XAA06060
	for <linux@cthulhu.engr.sgi.com>; Thu, 22 Apr 1999 23:07:51 -0400 (EDT)
	mail_from (clepple@foo.tho.org)
Received: from foo.tho.org (clepple@sprocket.foo.tho.org [206.223.45.3])
	by foo.tho.org (8.8.7/8.8.7) with ESMTP id XAA19796
	for <linux@cthulhu.engr.sgi.com>; Thu, 22 Apr 1999 23:07:49 -0400
Message-ID: <371FE405.2F817623@foo.tho.org>
Date: Fri, 23 Apr 1999 03:07:49 +0000
From: Charles Lepple <clepple@foo.tho.org>
X-Mailer: Mozilla 4.5 [en] (X11; U; Linux 2.0.36 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux/SGI <linux@cthulhu.engr.sgi.com>
Subject: am-utils and NIS
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Anyone have any experience with either of these under Linux/SGI? In
trying to rebuild the am-utils package to support NIS maps, I keep
getting this situation -- happens each time I try it :-(

[...]
gcc -shared -Wl,-soname -Wl,libamu.so.1 -o .libs/libamu.so.1.0.1
misc_rpc.lo mount_fs.lo mtab.lo nfs_prot_xdr.lo util.lo wire.lo
xdr_func.lo xutil.lo transputil.lo mtabutil.lo mountutil.lo umount_fs.lo
collect2: ld terminated with signal 6 [Aborted]
make[2]: *** [libamu.la] Error 1
make[2]: Leaving directory
`/usr/src/redhat/BUILD/am-utils-6.0a16/libamu'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/usr/src/redhat/BUILD/am-utils-6.0a16'
make: *** [all-recursive-am] Error 2

I'm building this from the SRPM, and I actually haven't done any
modifications to it yet -- it's just the am-utils-6.0a16-1.src.rpm from
ftp.linux.sgi.com. (built with 'rpm -bc am-utils.spec'). Oddly enough,
it doesn't appear that NIS support was detected in the am-utils
configure script (although the machine was bound to a domain at the
time). I won't spam the entire build log to the list, but I have it if
anyone has any leads on this and could benefit from it.

I don't know how related this is, but while ypmatch-type calls work OK,
ypcat generally returns errors like this:

green:~$ ypcat group 
eegrad:*:4000:test
eeugrad:*:6000:
faculty:*:2000:
staff:*:10:azam,harper,marchany,sysacct,clepple
eestaff:*:3000:azam,harper,marchany,sysacct
yp_all: clnt_call: RPC: Program not registered
[above repeats 3 to 5 times, then terminates with...]
No such map group.byname. Reason: RPC failure on NIS operation

Sorry to bug you all about this -- I know that NIS probably isn't high
on everyone's priority list...

Thanks in advance,

-- 
Charles Lepple
System Administrator, Virginia Tech EE Workstation Labs
clepple@ee.vt.edu || http://www.foo.tho.org/charles/
