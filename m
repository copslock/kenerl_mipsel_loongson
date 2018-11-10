Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Nov 2018 20:00:08 +0100 (CET)
Received: from rere.qmqm.pl ([91.227.64.183]:57832 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992905AbeKJS6fSez8M (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 10 Nov 2018 19:58:35 +0100
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 42smVL4zmZzBr;
        Sat, 10 Nov 2018 19:57:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1541876254; bh=7rQkWEZsCQfjIv+pT7sNkq69mXmlLknPPBmoeqeMNi8=;
        h=Date:From:Subject:To:Cc:From;
        b=HIgT0xWfizkbiexBP4DXIBLNK148Db5gKTPEWPO/lsxJwGcW2gWGtFL1lNrTND4H5
         AOhAsaORwRobZUIR1Wewwnic+33WGgRrTFJE6hYkQM6jSX4QsmGUijNMS6QUXlWadY
         lA7PKdx/OSO3QF46SY0wpc5Yn2c+2VhFxpTTSbXRnelkOatdS2mHmJ3D+q0vChZ1Ao
         alpXJLL/CZvrOJVuloP8PM7gdksO9LxK67kL6WNQvUBTXOKx1fCBh25N6wWppjr2YA
         sheg90lDfF5Vt9dZ5N/vxE96YE8P6YoQycZN9vTUpxTSfgNmBI0OkfLc6v05WMyA7s
         3SGFtgiZrbgOg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.100.2 at mail
Date:   Sat, 10 Nov 2018 19:58:29 +0100
Message-Id: <cover.1541876179.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH net-next 0/6] Remove VLAN.CFI overload
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     netdev@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Burton <paul.burton@mips.com>,
        Paul Mackerras <paulus@samba.org>,
        Ralf Baechle <ralf@linux-mips.org>, sparclinux@vger.kernel.org
Return-Path: <mirq-linux@rere.qmqm.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67222
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mirq-linux@rere.qmqm.pl
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

Fix BPF code/JITs to allow for separate VLAN_PRESENT flag
storage and finally move the flag to separate storage in skbuff.

This is final step to make CLAN.CFI transparent to core Linux
networking stack.

An #ifdef is introduced temporarily to mark fragments masking
VLAN_TAG_PRESENT. This is removed altogether in the final patch.

---
Michał Mirosław (6):
  net/skbuff: add macros for VLAN_PRESENT bit
  net/bpf: split VLAN_PRESENT bit handling from VLAN_TCI
  net/bpf_jit: MIPS: split VLAN_PRESENT bit handling from VLAN_TCI
  net/bpf_jit: PPC: split VLAN_PRESENT bit handling from VLAN_TCI
  net/bpf_jit: SPARC: split VLAN_PRESENT bit handling from VLAN_TCI
  net: remove VLAN_TAG_PRESENT

 arch/mips/net/bpf_jit.c          | 18 ++++++++---------
 arch/powerpc/net/bpf_jit_comp.c  | 15 +++++++-------
 arch/sparc/net/bpf_jit_comp_32.c | 13 ++++++------
 include/linux/if_vlan.h          | 11 ++++++-----
 include/linux/skbuff.h           | 10 +++++++++-
 lib/test_bpf.c                   | 14 +++++++------
 net/core/filter.c                | 34 ++++++++++++++------------------
 7 files changed, 60 insertions(+), 55 deletions(-)

-- 
2.19.1
