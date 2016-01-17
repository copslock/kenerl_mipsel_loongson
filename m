Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Jan 2016 14:54:47 +0100 (CET)
Received: from mout.gmx.net ([212.227.17.21]:53988 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008349AbcAQNyolzTvK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 17 Jan 2016 14:54:44 +0100
Received: from [192.168.123.49] ([37.24.8.189]) by mail.gmx.com (mrgmx101)
 with ESMTPSA (Nemesis) id 0LeRKD-1ZoUmC1oSr-00q9IV; Sun, 17 Jan 2016 14:54:33
 +0100
To:     lkml <linux-kernel@vger.kernel.org>, linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: =?UTF-8?Q?cannot_build_Linux_4.4:_arch/mips/kernel/signal.c:142:12:?=
 =?UTF-8?Q?_error:_=e2=80=98struct_ucontext=e2=80=99_has_no_member_named_?=
 =?UTF-8?B?4oCYdWNfZXh0Y29udGV4dOKAmQ==?=
X-Enigmail-Draft-Status: N1110
Message-ID: <569B9CFE.1090007@gmx.de>
Date:   Sun, 17 Jan 2016 14:54:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:Ihwm3WO7baeg5vjoUymQQDZ1+4voc/mTMyc+mlpowJl4/PO1FfS
 KDc5tNnuPKEibOxY2nzehoE9ds4BkJkMKJGz0se4tHr+i2cAXkLGwmYYip3k2dlXFHMQ/6b
 2NozLbxrOgRJbaV8nczEsicYub5ONuwCvCHonJNimlMyPVgx2EmUz0CXQQ8lyOsfWxldepk
 qxW7r0SMRzE6QiRdntkug==
X-UI-Out-Filterresults: notjunk:1;V01:K0:F+baYHJmalA=:Sg1KT92iNu4ze7fu+lD8JR
 s2QV2XUBX58fWQEEX9Sw5HNCmo+t1pIQsCqWPuEbdYTureW+CAdO0SqU1In/Vsmlc9s3ZQEgw
 xj8/zS70Sf/V5O9LC93xnIZRaHnqBGDiiBVyl4tR4snFrdo7zzwPVAE4DXuHXEq6X3yWrn2cB
 /G8uX/6ZpFe0FXzpn3teEBBZswewDiHLLL7k2j8BwSyXXCwAFY7wxLEoBclPVK1Z7nbdWCnyP
 aNIBwYcGuED1W/SQJo4xIQ9ueh0JkQVz0gRg+GMfmqJY3Z7pSSk2pMlwVTZ+/ZIz/6clpuK9f
 q35kZvksb+TZKmeNkeeeMhnuHHkU9XiTsCZir6DiDoEBBVTg9WcLXJW9qjugZXcV7xQEw0iSZ
 zg/uBRqWimLNFNkVEy1IkXmYujxcOxlaPyrFzTo7G+ox3bdBAEqD+d1/o46Gkl1mQ5CjswM1P
 InQM+AABuXk9bBpwFzq9G2JpRoAISpdBw+mxFg8jiMe2jL3ZJEwr3irza19F10RfhdPSK9EvC
 T1hjs0s+UM92ACEbLxt4rpvyNh5YR5mRfyVsSkJIJ8mj7eYh3/rL+Ph/VP85o7FMp20n60uJ7
 mnqUm0xR9gWx9GVuykn2SutDCOqYfyICTGMjZRalBEFhCZJUVvZjmTj0F6H3k3yXuJ7Vlooee
 cuOcrWZ6DNiPiUobOpvvsVFHfkfiWON26S6RLKaqPGoY1it18isRpz4yfff7F1ZmgCJnZVtqt
 EZ6uQwbBqOtPDbisVTKE+qyhpPEBOqziY4qVaOtcmnSK8Kbd6dyZYOofwXYI/jUpic/Zg335M
 gNLhD6B
Return-Path: <xypron.glpk@gmx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51178
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: xypron.glpk@gmx.de
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


HEAD is now at afd2ff9... Linux 4.4
arch/mips/kernel/signal.c: In function ‘sc_to_extcontext’:
arch/mips/kernel/signal.c:142:12: error: ‘struct ucontext’ has no member
named ‘uc_extcontext’
  return &uc->uc_extcontext;
            ^
In file included from include/linux/poll.h:11:0,
                 from include/linux/ring_buffer.h:7,
                 from include/linux/trace_events.h:5,
                 from include/trace/syscall.h:6,
                 from include/linux/syscalls.h:81,
                 from arch/mips/kernel/signal.c:26:
arch/mips/kernel/signal.c: In function ‘save_msa_extcontext’:
arch/mips/kernel/signal.c:170:40: error: dereferencing pointer to
incomplete type


Best regards

Heinrich Schuchardt
