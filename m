Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Aug 2005 20:14:10 +0100 (BST)
Received: from rproxy.gmail.com ([IPv6:::ffff:64.233.170.194]:38779 "EHLO
	rproxy.gmail.com") by linux-mips.org with ESMTP id <S8225252AbVHJTNt> convert rfc822-to-8bit;
	Wed, 10 Aug 2005 20:13:49 +0100
Received: by rproxy.gmail.com with SMTP id c16so159622rne
        for <linux-mips@linux-mips.org>; Wed, 10 Aug 2005 12:17:53 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=b56+78VZUaDzbjwvD/KnC4DQMLxXBnos68dgjm95G+kqtX4ep1tOgu1eOV7Bgbq9To0M+0mGNNLbJ9ldiPj4zLUSQscJipsOsOwxieVTViMdYMb4BpT0MvDkcL50fr9Rgj4TVtOw9QMbZUCBdtbt6J3KEH9S5EjA2EvUxIAHm5o=
Received: by 10.38.207.73 with SMTP id e73mr342367rng;
        Wed, 10 Aug 2005 12:17:53 -0700 (PDT)
Received: by 10.39.1.62 with HTTP; Wed, 10 Aug 2005 12:17:53 -0700 (PDT)
Message-ID: <dbce9302050810121728becc46@mail.gmail.com>
Date:	Wed, 10 Aug 2005 15:17:53 -0400
From:	David Cummings <real.psyence@gmail.com>
To:	linux-mips@linux-mips.org
Subject: shmem
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <real.psyence@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8732
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: real.psyence@gmail.com
Precedence: bulk
X-list: linux-mips

Hey, 
    I've run into a couple of programs that either when configuring or
running cannot allocate shared memory, or detect that it is available.
Is there an easy way to test whether or not it's available? should it
be mounted in a special way? Thanks for any info, my info is below.
kernel config:
http://davec.churchofthedollar.com/BigTom.config
output of mount:
   /dev/sda1 on / type ext3 (rw,noatime)
   proc on /proc type proc (rw)
   sysfs on /sys type sysfs (rw)
   udev on /dev type tmpfs (rw,nosuid)
   devpts on /dev/pts type devpts (rw)
   /dev/sda2 on /var type reiserfs (rw,noatime,notail)
   /dev/sda3 on /usr type reiserfs (rw,noatime)
   /dev/sda4 on /home type reiserfs (rw,noatime)
   shm on /dev/shm type tmpfs (rw,noexec,nosuid,nodev)

Thanks very much, 
-Dave
-- 
The way that can be named is not the Way.
