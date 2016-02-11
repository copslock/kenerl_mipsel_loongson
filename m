Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Feb 2016 15:11:21 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.126.135]:62322 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012528AbcBKOLT73yWX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Feb 2016 15:11:19 +0100
Received: from wuerfel.localnet ([78.42.132.4]) by mrelayeu.kundenserver.de
 (mreue003) with ESMTPSA (Nemesis) id 0LckSJ-1ZlUNe0Sc3-00k7Dp; Thu, 11 Feb
 2016 15:10:53 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Cc:     tj@kernel.org, hdegoede@redhat.com, david.daney@cavium.com,
        aleksey.makarov@caviumnetworks.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [Patch v9] SATA: OCTEON: support SATA on OCTEON platform
Date:   Thu, 11 Feb 2016 15:10:48 +0100
Message-ID: <3605862.y2fqt1KHLm@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <1455198788-24754-1-git-send-email-Zubair.Kakakhel@imgtec.com>
References: <1455198788-24754-1-git-send-email-Zubair.Kakakhel@imgtec.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V03:K0:Flyv4vHNYfP64js+LgFmjVIgVcPj8Itd6jw4v1PYiIwnHVoKDjN
 E8WCbdh5cPnltIatk1IYcBy4h+5OPCIV90iHE6pXXWViUCwsrMJ1ZV8snfz7rzvt54Mf2RG
 odG1k+dIhzHAYSgnFUlBXxV8xk2oJ3KX0PLoWRyyyERLa6Oquz2pKeZx6IzTBMlVIpDcN8n
 nOyFCfIqEN8XRKzuZFhWA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jOdenZyH1eQ=:erQ+nnA72aRTLG/Nm4ySk9
 voZPnbrxb7xl3zUdfw5CCQbdYEi/rw6YJtwPX/EEf/BoGs0CEMz+ql10OLyXM653f17hEGYGx
 IIF9f/ehvufXLkzZO0v64ltS6+oCSHXOs7FW1bOkXMh2qbjmod91KoNe+o8vNGrEcBjFgghO5
 jQW5SVzw2IKxqyzdr6cRKhpT5BWJJESAmoTE5COdwG9/og0UIGnaKaTILH2BtUYDvT0wxpoiu
 MKCh8lKS9J0R7SBGsgQa5Wb+h+HIIGgAXRoeJbac+FLLqjG/gjrExLTqgDxuGAosfPpaPWkku
 ggPUbM9MUW1/FBHJh2FGEIjUypqRFMBdxzxMqjbbNlfI3d+Bin4NY+rFPyFsrD8iin6vAlkxn
 Cq4ST/sYFfCEC37ongaHezqrRv1TiedCg0E1SR7EZ+n42Oc5DY5pOi/KvBjoSuH1hGIbjzLS/
 8M5w3k5augJMqpkOn/9KggqqccQ6PP/7rbaYN+xA0zg8VXTFH8zFwvWC1TTbCmiBEungXDg99
 JboA4CCJ6qciq8KsQTjjMR7o5+he+szztrGcTdYr3GXhs3aVxk+oAmPXZXiMhsPBPZp3hZ/nS
 o/IkolnX8WjxeNRsIaRvyoauXX1Zza8ksZDs1+p7yKUWanydBEYPHWo+Yjc+1yb1VTDDWEfOF
 Q9aGz3KLPMEV1tGI+MS4np7r+VOn0NDjdoN32yNCXlUschhlJviPV11gBDrG/0tCFrIwePbVu
 2VivBmodp4r923kw
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52004
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Thursday 11 February 2016 13:53:08 Zubair Lutfullah Kakakhel wrote:
> From: Aleksey Makarov <aleksey.makarov@caviumnetworks.com>
> 
> The OCTEON SATA controller is currently found on cn71XX devices.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Hans de Goede <hdegoede@redhat.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: David Daney <david.daney@cavium.com>
> Signed-off-by: Vinita Gupta <vgupta@caviumnetworks.com>
> Signed-off-by: Aleksey Makarov <aleksey.makarov@auriga.com>
> Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
