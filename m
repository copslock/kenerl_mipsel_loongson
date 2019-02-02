Return-Path: <SRS0=tpXJ=QJ=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7B3C282DB
	for <linux-mips@archiver.kernel.org>; Sat,  2 Feb 2019 15:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3ED820870
	for <linux-mips@archiver.kernel.org>; Sat,  2 Feb 2019 15:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sAHg/EBD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbfBBPfS (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sat, 2 Feb 2019 10:35:18 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44950 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727457AbfBBPfR (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Sat, 2 Feb 2019 10:35:17 -0500
Received: by mail-pf1-f195.google.com with SMTP id u6so4747425pfh.11;
        Sat, 02 Feb 2019 07:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MOOCgWMcqNx29qDNgQPggQZMAPyyh787m+mGlOgujkA=;
        b=sAHg/EBDlVWLBUIoEVcqMCGpCbLoqv7KzituBNXF6/2kks+YcGn2lBgl5/YTFtY0Vn
         I1pAoAoYa2Z38m+9nA/NnOv90SUfiN4Dxz/JbTSv8ymtdBTNtuXtFBwqOGbWM2dPkF4D
         djPgs2gC/NzPTcQRhZbvYWglZva7fp4KPyaNuBh9ya7J3yj8aecRhqIrqnnXDsdlrHV5
         WuRF3eqTv+p2tKoL1IJCH3lEJ4+x4bRJntdTPtRENO9EdenrErqfyifmYvnAVf1ImooQ
         L1yswmQ6N4GDnhxBteCU9FBXHtnp6ZFSI3otEvJaZVnCc+gZQlriXsLeXoEH/epAoJ15
         WJ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MOOCgWMcqNx29qDNgQPggQZMAPyyh787m+mGlOgujkA=;
        b=RDhe7fXRsIgNBvlJ9UIMsRXHruADEgF+v8v5lhn0GP1IpMTZYSmDwXaTg2kXG+pLxO
         ywucu5ilplU+nuCupje3pLx2a5vYvmB0j5c1G9U4Yz9hLrXyfFafIxNwShkP/UzrS0Pj
         MgaF3yLTDcos+7Np16imPl29OmOqn1HR27DR8njoZj3I+bg/FT3vrHaq2jDik9AlRlna
         KeFhkWbx1eEP8ul/pSQrjGfU/muf1ZfUB2b70PoUpHS8DcOV4uv3/VgUnyTCHTwl7nBU
         ji+odnitmH/HbhRe1LOTC5fvYeNqD7+0XI3RiNUUMj7UAs5CPiEeomxWKQv9jEtbeQlS
         waKQ==
X-Gm-Message-State: AHQUAubXm2WFFKeGRkEGsCdruFyovVPKKCCzyPYVcwyodcq2Tl9eQ0hU
        jVtAtkm7HbE0yBbBcPCAE+M=
X-Google-Smtp-Source: AHgI3IbkxPuSE2KX6LqGdFUe5JKhgMoIzKyTPxycKI5WjfhQPUFzvGqOV6pIQXLHL34393sEkcp+cg==
X-Received: by 2002:a63:c4b:: with SMTP id 11mr2065733pgm.451.1549121716228;
        Sat, 02 Feb 2019 07:35:16 -0800 (PST)
Received: from localhost.localdomain ([49.206.15.111])
        by smtp.gmail.com with ESMTPSA id m20sm16221611pgb.56.2019.02.02.07.35.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Feb 2019 07:35:15 -0800 (PST)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     davem@davemloft.net, linux-kernel@vger.kernel.org
Cc:     netdev@vger.kernel.org, arnd@arndb.de, y2038@lists.linaro.org,
        ccaulfie@redhat.com, chris@zankel.net, cluster-devel@redhat.com,
        deller@gmx.de, dhowells@redhat.com, fenghua.yu@intel.com,
        isdn@linux-pingi.de, jejb@parisc-linux.org,
        linux-afs@lists.infradead.org, linux-alpha@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, paulus@samba.org,
        ralf@linux-mips.org, rth@twiddle.net, schwidefsky@de.ibm.com,
        sparclinux@vger.kernel.org, tglx@linutronix.de,
        ubraun@linux.ibm.com
Subject: [PATCH net-next v5 00/12] net: y2038-safe socket timestamps 
Date:   Sat,  2 Feb 2019 07:34:42 -0800
Message-Id: <20190202153454.7121-1-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

The series introduces new socket timestamps that are
y2038 safe.

The time data types used for the existing socket timestamp
options: SO_TIMESTAMP, SO_TIMESTAMPNS and SO_TIMESTAMPING
are not y2038 safe. The series introduces SO_TIMESTAMP_NEW,
SO_TIMESTAMPNS_NEW and SO_TIMESTAMPING_NEW to replace these.
These new timestamps can be used on all architectures.

The alternative considered was to extend the sys_setsockopt()
by using the flags. We did not receive any strong opinions about
either of the approaches. Hence, this was chosen, as glibc folks
preferred this.

The series does not deal with updating the internal kernel socket
calls like rxrpc to make them y2038 safe. This will be dealt
with separately.

Note that the timestamps behavior already does not match the
man page specific behavior:
SIOCGSTAMP
    This ioctl should only be used if the socket option SO_TIMESTAMP
	is not set on the socket. Otherwise, it returns the timestamp of
	the last packet that was received while SO_TIMESTAMP was not set,
	or it fails if no such packet has been received,
	(i.e., ioctl(2) returns -1 with errno set to ENOENT).
	
The recommendation is to update the man page to remove the above statement.

The overview of the socket timestamp series is as below:
1. Delete asm specific socket.h when possible.
2. Support SO/SCM_TIMESTAMP* options only in userspace.
3. Rename current SO/SCM_TIMESTAMP* to SO/SCM_TIMESTAMP*_OLD.
3. Alter socket options so that SOCK_RCVTSTAMPNS does
   not rely on SOCK_RCVTSTAMP.
4. Introduce y2038 safe types for socket timestamp.
5. Introduce new y2038 safe socket options SO/SCM_TIMESTAMP*_NEW.
6. Intorduce new y2038 safe socket timeout options.

Changes since v4:
* Fixed the typo in calling sock_get_timeout()

Changes since v3:
* Rebased onto net-next and fixups as per review comments
* Merged the socket timeout series
* Integrated Arnd's patch to simplify compat handling of timeout syscalls

Changes since v2:
* Removed extra functions to reduce diff churn as per code review

Changes since v1:
* Dropped the change to disentangle sock flags
* Renamed sock_timeval to __kernel_sock_timeval
* Updated a few comments
* Added documentation changes

Arnd Bergmann (1):
  socket: move compat timeout handling into sock.c

Deepa Dinamani (11):
  selftests: add missing include unistd
  arch: Use asm-generic/socket.h when possible
  sockopt: Rename SO_TIMESTAMP* to SO_TIMESTAMP*_OLD
  arch: sparc: Override struct __kernel_old_timeval
  socket: Use old_timeval types for socket timestamps
  socket: Add struct __kernel_sock_timeval
  socket: Add SO_TIMESTAMP[NS]_NEW
  socket: Add SO_TIMESTAMPING_NEW
  socket: Update timestamping Documentation
  socket: Rename SO_RCVTIMEO/ SO_SNDTIMEO with _OLD suffixes
  sock: Add SO_RCVTIMEO_NEW and SO_SNDTIMEO_NEW

 Documentation/networking/timestamping.txt     |  43 ++++-
 arch/alpha/include/uapi/asm/socket.h          |  47 ++++--
 arch/ia64/include/uapi/asm/Kbuild             |   1 +
 arch/ia64/include/uapi/asm/socket.h           | 122 --------------
 arch/mips/include/uapi/asm/socket.h           |  47 ++++--
 arch/parisc/include/uapi/asm/socket.h         |  46 ++++--
 arch/powerpc/include/uapi/asm/socket.h        |   4 +-
 arch/s390/include/uapi/asm/Kbuild             |   1 +
 arch/s390/include/uapi/asm/socket.h           | 119 --------------
 arch/sparc/include/uapi/asm/posix_types.h     |  10 ++
 arch/sparc/include/uapi/asm/socket.h          |  49 ++++--
 arch/x86/include/uapi/asm/Kbuild              |   1 +
 arch/x86/include/uapi/asm/socket.h            |   1 -
 arch/xtensa/include/asm/Kbuild                |   1 +
 arch/xtensa/include/uapi/asm/Kbuild           |   1 +
 arch/xtensa/include/uapi/asm/socket.h         | 124 --------------
 drivers/isdn/mISDN/socket.c                   |   2 +-
 fs/dlm/lowcomms.c                             |   4 +-
 include/linux/skbuff.h                        |  24 ++-
 include/linux/socket.h                        |   8 +
 include/net/sock.h                            |   1 +
 include/uapi/asm-generic/socket.h             |  48 ++++--
 include/uapi/linux/errqueue.h                 |   4 +
 include/uapi/linux/time.h                     |   7 +
 net/bluetooth/hci_sock.c                      |   4 +-
 net/compat.c                                  |  78 +--------
 net/core/scm.c                                |  27 ++++
 net/core/sock.c                               | 151 +++++++++++++-----
 net/ipv4/tcp.c                                |  61 ++++---
 net/rds/af_rds.c                              |  10 +-
 net/rds/recv.c                                |  18 ++-
 net/rxrpc/local_object.c                      |   2 +-
 net/smc/af_smc.c                              |   3 +-
 net/socket.c                                  |  50 ++++--
 net/vmw_vsock/af_vsock.c                      |   4 +-
 .../networking/timestamping/rxtimestamp.c     |   1 +
 36 files changed, 541 insertions(+), 583 deletions(-)
 delete mode 100644 arch/ia64/include/uapi/asm/socket.h
 delete mode 100644 arch/s390/include/uapi/asm/socket.h
 delete mode 100644 arch/x86/include/uapi/asm/socket.h
 delete mode 100644 arch/xtensa/include/uapi/asm/socket.h

-- 
2.17.1

Cc: ccaulfie@redhat.com
Cc: chris@zankel.net
Cc: cluster-devel@redhat.com
Cc: davem@davemloft.net
Cc: deller@gmx.de
Cc: dhowells@redhat.com
Cc: fenghua.yu@intel.com
Cc: isdn@linux-pingi.de
Cc: jejb@parisc-linux.org
Cc: linux-afs@lists.infradead.org
Cc: linux-alpha@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: linux-ia64@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: linux-mips@vger.kernel.org
Cc: linux-parisc@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-rdma@vger.kernel.org
Cc: linux-s390@vger.kernel.org
Cc: linux-xtensa@linux-xtensa.org
Cc: netdev@vger.kernel.org
Cc: paulus@samba.org
Cc: ralf@linux-mips.org
Cc: rth@twiddle.net
Cc: schwidefsky@de.ibm.com
Cc: sparclinux@vger.kernel.org
Cc: tglx@linutronix.de
Cc: ubraun@linux.ibm.com
