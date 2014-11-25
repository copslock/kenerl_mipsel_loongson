Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Nov 2014 11:21:18 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.126.187]:52116 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006988AbaKYKVQaYbem (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Nov 2014 11:21:16 +0100
Received: from klappe2.localnet (HSI-KBW-149-172-15-242.hsi13.kabel-badenwuerttemberg.de [149.172.15.242])
        by mrelayeu.kundenserver.de (node=mreue004) with ESMTP (Nemesis)
        id 0M3fC1-1YB9nh0Dlh-00rFG4; Tue, 25 Nov 2014 11:21:08 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Kevin Cernekee <cernekee@gmail.com>
Subject: Re: [PATCH V3 0/7] serial: Configure {big,native}-endian MMIO accesses via DT
Date:   Tue, 25 Nov 2014 11:21:03 +0100
User-Agent: KMail/1.12.2 (Linux/3.8.0-35-generic; KDE/4.3.2; x86_64; ; )
Cc:     gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org,
        grant.likely@linaro.org, f.fainelli@gmail.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org
References: <1416872182-6440-1-git-send-email-cernekee@gmail.com>
In-Reply-To: <1416872182-6440-1-git-send-email-cernekee@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201411251121.04160.arnd@arndb.de>
X-Provags-ID: V02:K0:MgWV9I+XHiHiKEoKSmKDCEvO+dwF7Vjeni6oLh4G5pP
 0P498BotTA+HD2pG1C5SDQ6hS/RkjR6w1Sk0oMFAdpsypKJ/4D
 BlHPEQsjy3nXL4czRsfJ343JEBHcQkJS+eHxOUT219wCYSdVOi
 Cn9lCV3EcGDYnZrxkWSSFpCr38dTXXf4ADjrLBBDCZQUnCzi7A
 qp2KP7fnSNgYPHGxbB9qVU3wZbl/XY+TKJJIZhMXRcV61v7zCl
 H7TQtvVUdOdMkasDqxw3mfzUX+vkPccvc4fwNBm5xblQhFtbjy
 w4zicaSofjTo2sMe1hiE80nbvGsHXjqzUGwLl2iW1Xw+zECswt
 MHyb9I6wdTqpSy77RrJ8c62N1jCH5ybB+P52benQt
X-UI-Out-Filterresults: notjunk:1;
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44427
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

On Tuesday 25 November 2014, Kevin Cernekee wrote:
> 
> My last submission attempted to work around serial driver coexistence
> problems on multiplatform kernels.  Since there are still questions
> surrounding the best way to solve that problem, this patch series
> will focus on the narrower topic of big endian MMIO support on serial.
> 
> 
> V2->V3:
> 
>  - Document the new DT properties.
> 
>  - Add libfdt-based wrapper, to complement the "struct device_node" based
>    version.
> 
>  - Restructure early_init_dt_scan_chosen_serial() changes to use a
>    temporary variable, so it is easy to add more of_setup_earlycon()
>    properties later.
> 
>  - Make of_serial and serial8250 honor the new "big-endian" property.

Looks all good to me,

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
