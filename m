Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Feb 2016 14:29:13 +0100 (CET)
Received: from hauke-m.de ([5.39.93.123]:51730 "EHLO hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009334AbcBUN3LIgcbH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 21 Feb 2016 14:29:11 +0100
Received: from [192.168.178.24] (p5DE94359.dip0.t-ipconnect.de [93.233.67.89])
        by hauke-m.de (Postfix) with ESMTPSA id 9F8BA1001AD;
        Sun, 21 Feb 2016 14:29:10 +0100 (CET)
Subject: Re: [PATCH] MIPS: vdso: flush the vdso data page to update it on all
 processes
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
References: <1456059443-13889-1-git-send-email-hauke@hauke-m.de>
Cc:     alex.smith@imgtec.com,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
From:   Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <56C9BBA6.4080607@hauke-m.de>
Date:   Sun, 21 Feb 2016 14:29:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.5.0
MIME-Version: 1.0
In-Reply-To: <1456059443-13889-1-git-send-email-hauke@hauke-m.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52149
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

On 02/21/2016 01:57 PM, Hauke Mehrtens wrote:
> Without flushing the vdso data page the vdso call is working on dated
> or unsynced data. This resulted in problems where the clock_gettime
> vdso call returned a time 6 seconds later after a 3 sounds sleep,
> while the syscall reported a time 3 sounds later like expected. This
> happened very often and I got these ping results for example:
> 
> root@OpenWrt:/# ping 192.168.1.255
> PING 192.168.1.255 (192.168.1.255): 56 data bytes
> 64 bytes from 192.168.1.3: seq=0 ttl=64 time=0.688 ms
> 64 bytes from 192.168.1.3: seq=1 ttl=64 time=4294172.045 ms
> 64 bytes from 192.168.1.3: seq=2 ttl=64 time=4293968.105 ms
> 64 bytes from 192.168.1.3: seq=3 ttl=64 time=4294055.920 ms
> 64 bytes from 192.168.1.3: seq=4 ttl=64 time=4294671.913 ms
> 
> The flush is now done like it is done on the arm architecture code.
> 
> This was tested on a Lantiq/Intel VRX288 (MIPS BE 34Kc V5.6 CPU with
> two VPEs)
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> Cc: <stable@vger.kernel.org> # v4.4+

I did some more tests and it is better now, but the problem is not
completely fixed, see this:

root@OpenWrt:/# ping 192.168.1.195
PING 192.168.1.195 (192.168.1.195): 56 data bytes
64 bytes from 192.168.1.195: seq=0 ttl=64 time=0.506 ms
64 bytes from 192.168.1.195: seq=1 ttl=64 time=4294951.724 ms
64 bytes from 192.168.1.195: seq=2 ttl=64 time=0.441 ms
64 bytes from 192.168.1.195: seq=3 ttl=64 time=0.412 ms
64 bytes from 192.168.1.195: seq=4 ttl=64 time=0.440 ms
64 bytes from 192.168.1.195: seq=5 ttl=64 time=0.435 ms
64 bytes from 192.168.1.195: seq=6 ttl=64 time=0.403 ms
64 bytes from 192.168.1.195: seq=7 ttl=64 time=0.406 ms
64 bytes from 192.168.1.195: seq=8 ttl=64 time=0.403 ms
64 bytes from 192.168.1.195: seq=9 ttl=64 time=0.406 ms
64 bytes from 192.168.1.195: seq=10 ttl=64 time=0.448 ms
64 bytes from 192.168.1.195: seq=11 ttl=64 time=0.399 ms
64 bytes from 192.168.1.195: seq=12 ttl=64 time=0.436 ms
64 bytes from 192.168.1.195: seq=13 ttl=64 time=0.438 ms
64 bytes from 192.168.1.195: seq=14 ttl=64 time=0.439 ms


Does anybody has an idea what else cloud be wrong?

Hauke
