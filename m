Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Oct 2012 21:51:50 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:7801 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6817053Ab2JDTvi2Fp0P (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 4 Oct 2012 21:51:38 +0200
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q94JpZo9026777
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Thu, 4 Oct 2012 15:51:35 -0400
Received: from warthog.procyon.org.uk (ovpn-113-54.phx2.redhat.com [10.3.113.54])
        by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id q94JpXVY000908;
        Thu, 4 Oct 2012 15:51:34 -0400
From:   David Howells <dhowells@redhat.com>
To:     ralf@linux-mips.org
Cc:     dhowells@redhat.com, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Disintegrate UAPI for mips
Date:   Thu, 04 Oct 2012 20:51:33 +0100
Message-ID: <17389.1349380293@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.11
X-archive-position: 34611
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dhowells@redhat.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Can you merge the following branch into the mips tree please.

This is to complete part of the UAPI disintegration for which the preparatory
patches were pulled recently.

Note that there are some fixup patches which are at the base of the branch
aimed at you, plus all arches get the asm-generic branch merged in too.

The following changes since commit 612a9aab56a93533e76e3ad91642db7033e03b69:

  Merge branch 'drm-next' of git://people.freedesktop.org/~airlied/linux (2012-10-03 23:29:23 -0700)

are available in the git repository at:


  git://git.infradead.org/users/dhowells/linux-headers.git disintegrate-mips

for you to fetch changes up to 49c611211de4006faefba4ea9a4219ed97f71707:

  UAPI: (Scripted) Disintegrate arch/mips/include/asm (2012-10-04 18:21:03 +0100)

----------------------------------------------------------------
David Howells (6):
      UAPI: Fix the guards on various asm/unistd.h files
      UAPI: Split compound conditionals containing __KERNEL__ in Arm64
      Merge remote-tracking branch 'c6x/for-linux-next' into uapi-prep
      UAPI: Fix conditional header installation handling (notably kvm_para.h on m68k)
      UAPI: (Scripted) Disintegrate include/asm-generic
      UAPI: (Scripted) Disintegrate arch/mips/include/asm

Mark Salter (2):
      c6x: make dsk6455 the default config
      c6x: remove c6x signal.h

 arch/arm64/include/asm/hwcap.h                 |    4 +-
 arch/arm64/include/asm/stat.h                  |    4 +-
 arch/arm64/include/asm/unistd.h                |    8 +-
 arch/arm64/include/asm/unistd32.h              |    4 -
 arch/c6x/Makefile                              |    2 +
 arch/c6x/include/asm/Kbuild                    |    1 +
 arch/c6x/include/asm/signal.h                  |   17 -
 arch/c6x/include/asm/unistd.h                  |    4 -
 arch/hexagon/include/asm/unistd.h              |    5 -
 arch/mips/include/asm/Kbuild                   |    5 -
 arch/mips/include/asm/errno.h                  |  120 +--
 arch/mips/include/asm/ptrace.h                 |  107 +--
 arch/mips/include/asm/setup.h                  |    5 +-
 arch/mips/include/asm/sigcontext.h             |   66 +-
 arch/mips/include/asm/siginfo.h                |  104 +--
 arch/mips/include/asm/signal.h                 |  115 +--
 arch/mips/include/asm/socket.h                 |   83 +-
 arch/mips/include/asm/termios.h                |   73 +-
 arch/mips/include/asm/types.h                  |   16 +-
 arch/mips/include/asm/unistd.h                 | 1019 +----------------------
 arch/mips/include/uapi/asm/Kbuild              |   34 +
 arch/mips/include/{ => uapi}/asm/auxvec.h      |    0
 arch/mips/include/{ => uapi}/asm/bitsperlong.h |    0
 arch/mips/include/{ => uapi}/asm/byteorder.h   |    0
 arch/mips/include/{ => uapi}/asm/cachectl.h    |    0
 arch/mips/include/uapi/asm/errno.h             |  129 +++
 arch/mips/include/{ => uapi}/asm/fcntl.h       |    0
 arch/mips/include/{ => uapi}/asm/ioctl.h       |    0
 arch/mips/include/{ => uapi}/asm/ioctls.h      |    0
 arch/mips/include/{ => uapi}/asm/ipcbuf.h      |    0
 arch/mips/include/{ => uapi}/asm/kvm_para.h    |    0
 arch/mips/include/{ => uapi}/asm/mman.h        |    0
 arch/mips/include/{ => uapi}/asm/msgbuf.h      |    0
 arch/mips/include/{ => uapi}/asm/param.h       |    0
 arch/mips/include/{ => uapi}/asm/poll.h        |    0
 arch/mips/include/{ => uapi}/asm/posix_types.h |    0
 arch/mips/include/uapi/asm/ptrace.h            |  116 +++
 arch/mips/include/{ => uapi}/asm/resource.h    |    0
 arch/mips/include/{ => uapi}/asm/sembuf.h      |    0
 arch/mips/include/uapi/asm/setup.h             |    7 +
 arch/mips/include/{ => uapi}/asm/sgidefs.h     |    0
 arch/mips/include/{ => uapi}/asm/shmbuf.h      |    0
 arch/mips/include/uapi/asm/sigcontext.h        |   78 ++
 arch/mips/include/uapi/asm/siginfo.h           |  114 +++
 arch/mips/include/uapi/asm/signal.h            |  123 +++
 arch/mips/include/uapi/asm/socket.h            |   93 +++
 arch/mips/include/{ => uapi}/asm/sockios.h     |    0
 arch/mips/include/{ => uapi}/asm/stat.h        |    0
 arch/mips/include/{ => uapi}/asm/statfs.h      |    0
 arch/mips/include/{ => uapi}/asm/swab.h        |    0
 arch/mips/include/{ => uapi}/asm/sysmips.h     |    0
 arch/mips/include/{ => uapi}/asm/termbits.h    |    0
 arch/mips/include/uapi/asm/termios.h           |   80 ++
 arch/mips/include/uapi/asm/types.h             |   27 +
 arch/mips/include/uapi/asm/unistd.h            | 1032 ++++++++++++++++++++++++
 arch/openrisc/include/asm/unistd.h             |    5 -
 arch/score/include/asm/unistd.h                |    5 -
 arch/tile/include/asm/unistd.h                 |    5 -
 arch/unicore32/include/asm/unistd.h            |    4 -
 include/asm-generic/Kbuild                     |   35 -
 include/asm-generic/bitsperlong.h              |   13 +-
 include/asm-generic/int-l64.h                  |   26 +-
 include/asm-generic/int-ll64.h                 |   31 +-
 include/asm-generic/ioctl.h                    |   95 +--
 include/asm-generic/kvm_para.h                 |    5 +-
 include/asm-generic/param.h                    |   17 +-
 include/asm-generic/resource.h                 |   66 +-
 include/asm-generic/siginfo.h                  |  297 +------
 include/asm-generic/signal.h                   |  117 +--
 include/asm-generic/statfs.h                   |   81 +-
 include/asm-generic/termios.h                  |   49 +-
 include/asm-generic/unistd.h                   |  911 +--------------------
 include/linux/Kbuild                           |    9 +-
 include/uapi/asm-generic/Kbuild                |   35 +
 include/{ => uapi}/asm-generic/auxvec.h        |    0
 include/uapi/asm-generic/bitsperlong.h         |   15 +
 include/{ => uapi}/asm-generic/errno-base.h    |    0
 include/{ => uapi}/asm-generic/errno.h         |    0
 include/{ => uapi}/asm-generic/fcntl.h         |    0
 include/uapi/asm-generic/int-l64.h             |   34 +
 include/uapi/asm-generic/int-ll64.h            |   39 +
 include/uapi/asm-generic/ioctl.h               |   98 +++
 include/{ => uapi}/asm-generic/ioctls.h        |    0
 include/{ => uapi}/asm-generic/ipcbuf.h        |    0
 include/{ => uapi}/asm-generic/mman-common.h   |    0
 include/{ => uapi}/asm-generic/mman.h          |    0
 include/{ => uapi}/asm-generic/msgbuf.h        |    0
 include/uapi/asm-generic/param.h               |   19 +
 include/{ => uapi}/asm-generic/poll.h          |    0
 include/{ => uapi}/asm-generic/posix_types.h   |    0
 include/uapi/asm-generic/resource.h            |   68 ++
 include/{ => uapi}/asm-generic/sembuf.h        |    0
 include/{ => uapi}/asm-generic/setup.h         |    0
 include/{ => uapi}/asm-generic/shmbuf.h        |    0
 include/{ => uapi}/asm-generic/shmparam.h      |    0
 include/uapi/asm-generic/siginfo.h             |  298 +++++++
 include/{ => uapi}/asm-generic/signal-defs.h   |    0
 include/uapi/asm-generic/signal.h              |  123 +++
 include/{ => uapi}/asm-generic/socket.h        |    0
 include/{ => uapi}/asm-generic/sockios.h       |    0
 include/{ => uapi}/asm-generic/stat.h          |    0
 include/uapi/asm-generic/statfs.h              |   83 ++
 include/{ => uapi}/asm-generic/swab.h          |    0
 include/{ => uapi}/asm-generic/termbits.h      |    0
 include/uapi/asm-generic/termios.h             |   50 ++
 include/{ => uapi}/asm-generic/types.h         |    0
 include/{ => uapi}/asm-generic/ucontext.h      |    0
 include/uapi/asm-generic/unistd.h              |  902 +++++++++++++++++++++
 security/apparmor/Makefile                     |    2 +-
 109 files changed, 3636 insertions(+), 3496 deletions(-)
 delete mode 100644 arch/c6x/include/asm/signal.h
 rename arch/mips/include/{ => uapi}/asm/auxvec.h (100%)
 rename arch/mips/include/{ => uapi}/asm/bitsperlong.h (100%)
 rename arch/mips/include/{ => uapi}/asm/byteorder.h (100%)
 rename arch/mips/include/{ => uapi}/asm/cachectl.h (100%)
 create mode 100644 arch/mips/include/uapi/asm/errno.h
 rename arch/mips/include/{ => uapi}/asm/fcntl.h (100%)
 rename arch/mips/include/{ => uapi}/asm/ioctl.h (100%)
 rename arch/mips/include/{ => uapi}/asm/ioctls.h (100%)
 rename arch/mips/include/{ => uapi}/asm/ipcbuf.h (100%)
 rename arch/mips/include/{ => uapi}/asm/kvm_para.h (100%)
 rename arch/mips/include/{ => uapi}/asm/mman.h (100%)
 rename arch/mips/include/{ => uapi}/asm/msgbuf.h (100%)
 rename arch/mips/include/{ => uapi}/asm/param.h (100%)
 rename arch/mips/include/{ => uapi}/asm/poll.h (100%)
 rename arch/mips/include/{ => uapi}/asm/posix_types.h (100%)
 create mode 100644 arch/mips/include/uapi/asm/ptrace.h
 rename arch/mips/include/{ => uapi}/asm/resource.h (100%)
 rename arch/mips/include/{ => uapi}/asm/sembuf.h (100%)
 create mode 100644 arch/mips/include/uapi/asm/setup.h
 rename arch/mips/include/{ => uapi}/asm/sgidefs.h (100%)
 rename arch/mips/include/{ => uapi}/asm/shmbuf.h (100%)
 create mode 100644 arch/mips/include/uapi/asm/sigcontext.h
 create mode 100644 arch/mips/include/uapi/asm/siginfo.h
 create mode 100644 arch/mips/include/uapi/asm/signal.h
 create mode 100644 arch/mips/include/uapi/asm/socket.h
 rename arch/mips/include/{ => uapi}/asm/sockios.h (100%)
 rename arch/mips/include/{ => uapi}/asm/stat.h (100%)
 rename arch/mips/include/{ => uapi}/asm/statfs.h (100%)
 rename arch/mips/include/{ => uapi}/asm/swab.h (100%)
 rename arch/mips/include/{ => uapi}/asm/sysmips.h (100%)
 rename arch/mips/include/{ => uapi}/asm/termbits.h (100%)
 create mode 100644 arch/mips/include/uapi/asm/termios.h
 create mode 100644 arch/mips/include/uapi/asm/types.h
 create mode 100644 arch/mips/include/uapi/asm/unistd.h
 rename include/{ => uapi}/asm-generic/auxvec.h (100%)
 create mode 100644 include/uapi/asm-generic/bitsperlong.h
 rename include/{ => uapi}/asm-generic/errno-base.h (100%)
 rename include/{ => uapi}/asm-generic/errno.h (100%)
 rename include/{ => uapi}/asm-generic/fcntl.h (100%)
 create mode 100644 include/uapi/asm-generic/int-l64.h
 create mode 100644 include/uapi/asm-generic/int-ll64.h
 create mode 100644 include/uapi/asm-generic/ioctl.h
 rename include/{ => uapi}/asm-generic/ioctls.h (100%)
 rename include/{ => uapi}/asm-generic/ipcbuf.h (100%)
 create mode 100644 include/uapi/asm-generic/kvm_para.h
 rename include/{ => uapi}/asm-generic/mman-common.h (100%)
 rename include/{ => uapi}/asm-generic/mman.h (100%)
 rename include/{ => uapi}/asm-generic/msgbuf.h (100%)
 create mode 100644 include/uapi/asm-generic/param.h
 rename include/{ => uapi}/asm-generic/poll.h (100%)
 rename include/{ => uapi}/asm-generic/posix_types.h (100%)
 create mode 100644 include/uapi/asm-generic/resource.h
 rename include/{ => uapi}/asm-generic/sembuf.h (100%)
 rename include/{ => uapi}/asm-generic/setup.h (100%)
 rename include/{ => uapi}/asm-generic/shmbuf.h (100%)
 rename include/{ => uapi}/asm-generic/shmparam.h (100%)
 create mode 100644 include/uapi/asm-generic/siginfo.h
 rename include/{ => uapi}/asm-generic/signal-defs.h (100%)
 create mode 100644 include/uapi/asm-generic/signal.h
 rename include/{ => uapi}/asm-generic/socket.h (100%)
 rename include/{ => uapi}/asm-generic/sockios.h (100%)
 rename include/{ => uapi}/asm-generic/stat.h (100%)
 create mode 100644 include/uapi/asm-generic/statfs.h
 rename include/{ => uapi}/asm-generic/swab.h (100%)
 rename include/{ => uapi}/asm-generic/termbits.h (100%)
 create mode 100644 include/uapi/asm-generic/termios.h
 rename include/{ => uapi}/asm-generic/types.h (100%)
 rename include/{ => uapi}/asm-generic/ucontext.h (100%)
 create mode 100644 include/uapi/asm-generic/unistd.h
.
