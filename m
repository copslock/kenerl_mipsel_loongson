Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Jul 2013 19:46:02 +0200 (CEST)
Received: from mail-pa0-f46.google.com ([209.85.220.46]:46702 "EHLO
        mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6834840Ab3GRRpjk2VFx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Jul 2013 19:45:39 +0200
Received: by mail-pa0-f46.google.com with SMTP id fa11so3484454pad.19
        for <multiple recipients>; Thu, 18 Jul 2013 10:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=matI9Jsyd8up33ltvOKzl7y9m0AvrrC4H6vH1vdbBtc=;
        b=pK9a9CWNxDkFDa0yvj+GoUw4nOmGYx2PLgXiOk87I4jm3ksI7AsDPefz90aYzM18br
         KqBLQaMmNrjhzhZn0dyQQBsRwpUuyy1SVFsyS4Hy/Zx9Juc7790oF8Si9yU0iqD8WqaW
         nt7J8WMS+HAyn/Rk5bjfnu7XLpxXXlElk8NrgLR3MaRtiMNGuICmDvhu3Ygw9HmABFfe
         DJepFGwgOR3Xv7rltjOGBAWSv9YrOrpIILku5KXKSrmJ3yreC7Kd+Thk8nWHkUjxKNUr
         8TlQk937/y5VTEMQdGKFyfkNQmJ02tJZpPdogfIhUd9j20wGj+0cJFCXv2NkgJ5rEj1y
         bmrw==
X-Received: by 10.66.233.104 with SMTP id tv8mr7153011pac.111.1374169524083;
        Thu, 18 Jul 2013 10:45:24 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id bb1sm5078127pbc.10.2013.07.18.10.45.22
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 18 Jul 2013 10:45:23 -0700 (PDT)
Message-ID: <51E829B1.40406@gmail.com>
Date:   Thu, 18 Jul 2013 10:45:21 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130514 Thunderbird/17.0.6
MIME-Version: 1.0
To:     Faidon Liambotis <paravoid@debian.org>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     linux-mips@linux-mips.org, Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH] MIPS: octeon: fix DT pruning bug with pip ports
References: <1373580489-23142-1-git-send-email-paravoid@debian.org>
In-Reply-To: <1373580489-23142-1-git-send-email-paravoid@debian.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37320
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 07/11/2013 03:08 PM, Faidon Liambotis wrote:
> During the pruning of the device tree octeon_fdt_pip_iface() is called
> for each PIP interface and every port up to the port count is removed
> from the device tree. However, the count was set to the return value of
> cvmx_helper_interface_enumerate() which doesn't actually return the
> count but just returns zero on success. This effectively removed *all*
> ports from the tree.
>
> Use cvmx_helper_ports_on_interface() instead to fix this. This
> successfully restores the 3 ports of my ERLite-3 and fixes the "kernel
> assigns random MAC addresses" issue.
>
> Signed-off-by: Faidon Liambotis <paravoid@debian.org>

Yes, this seems to be correct.  It doesn't seem to break my ebt3000 
board so...

Acked-by: David Daney <david.daney@cavium.com>

Ralf, please try to get it merged for 3.11, thanks.



> ---
>   arch/mips/cavium-octeon/octeon-platform.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium-octeon/octeon-platform.c
> index 389512e..250eb20 100644
> --- a/arch/mips/cavium-octeon/octeon-platform.c
> +++ b/arch/mips/cavium-octeon/octeon-platform.c
> @@ -334,9 +334,10 @@ static void __init octeon_fdt_pip_iface(int pip, int idx, u64 *pmac)
>   	char name_buffer[20];
>   	int iface;
>   	int p;
> -	int count;
> +	int count = 0;
>
> -	count = cvmx_helper_interface_enumerate(idx);
> +	if (cvmx_helper_interface_enumerate(idx) == 0)
> +		count = cvmx_helper_ports_on_interface(idx);
>
>   	snprintf(name_buffer, sizeof(name_buffer), "interface@%d", idx);
>   	iface = fdt_subnode_offset(initial_boot_params, pip, name_buffer);
>
