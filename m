Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Jun 2005 00:49:32 +0100 (BST)
Received: from wproxy.gmail.com ([IPv6:::ffff:64.233.184.206]:51769 "EHLO
	wproxy.gmail.com") by linux-mips.org with ESMTP id <S8225334AbVFVXtP> convert rfc822-to-8bit;
	Thu, 23 Jun 2005 00:49:15 +0100
Received: by wproxy.gmail.com with SMTP id 57so564186wri
        for <linux-mips@linux-mips.org>; Wed, 22 Jun 2005 16:48:10 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=E4cZ+TEKIeTeg/e15A4qP/6gX/l7Q/UHC8qOvXx8rRiD1GqDhL4ftgUiPXs9XKsK+LkJuprzx0ZQQGrQ+VdUpEomYEzI9ik8DeOJ7e09BfCp1kp1EQP7cTuvoRyrb3rLhFSW7NCA9AhnCChacbzD1n1FPDkbv9IdrPlNxcpahzY=
Received: by 10.54.15.71 with SMTP id 71mr775821wro;
        Wed, 22 Jun 2005 16:48:10 -0700 (PDT)
Received: by 10.54.71.11 with HTTP; Wed, 22 Jun 2005 16:48:10 -0700 (PDT)
Message-ID: <2db32b720506221648eed011b@mail.gmail.com>
Date:	Wed, 22 Jun 2005 16:48:10 -0700
From:	rolf liu <rolfliu@gmail.com>
Reply-To: rolf liu <rolfliu@gmail.com>
To:	linux-mips@linux-mips.org
Subject: booting error on db1550 for kernel 2.4.31
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <rolfliu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8146
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rolfliu@gmail.com
Precedence: bulk
X-list: linux-mips

I compiled the kernel 2.4.31 using sde tools. Download linux to db1550
through yamon. but the kernel can't find the NFS root. I tried the NFS
system from other linux box, and the NFS is ok. Who met this same
problem?

Looking up port of RPC 100003/2 on 10.200.0.198
RPC: sendmsg returned error 128
portmap: RPC call returned error 128
Root-NFS: Unable to get nfsd port number from server, using default
Looking up port of RPC 100005/1 on 10.200.0.198
RPC: sendmsg returned error 128
portmap: RPC call returned error 128
Root-NFS: Unable to get mountd port number from server, using default
RPC: sendmsg returned error 128
mount: RPC call returned error 128
Root-NFS: Server returned error -128 while mounting /nfsroot/mipsel
VFS: Unable to mount root fs via NFS, trying floppy.
kmod: failed to exec /sbin/modprobe -s -k block-major-2, errno = 2
VFS: Cannot open root device "" or 02:00
Please append a correct "root=" boot option
Kernel panic: VFS: Unable to mount root fs on 02:00 

Thanks for the suggestion
