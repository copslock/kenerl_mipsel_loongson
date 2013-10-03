Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Oct 2013 09:14:44 +0200 (CEST)
Received: from mail-ee0-f42.google.com ([74.125.83.42]:55813 "EHLO
        mail-ee0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816022Ab3JCHOlnpoWI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Oct 2013 09:14:41 +0200
Received: by mail-ee0-f42.google.com with SMTP id b45so877338eek.29
        for <linux-mips@linux-mips.org>; Thu, 03 Oct 2013 00:14:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=ldyvT2XdunLzGQJ6D1fTtr+tecXla4lvpJQyXcCCo+s=;
        b=JFea4yv3HjmBORfbaTcfR2lOek/6JK1nKEzskgkAPgjtvzHNbKU5Pwb+XuniDYVjaB
         7DTFoERsR5/wWizvqvd5fRA3xb/jbA6UHPkZD4TpsCjQ4WKzbw/s1xJTS2wbg/7shcoR
         UPz0icZ/jBQ4aIZ67J/t7SzlHTY9+vx3Ur6VXhwNDN5bePug34rD6fUdYd5je1WPq9V/
         jY3pVwqj/vwCy369R0ZzBojzInjVR5C8FBARgm84PipGDLRIakxrSzU+jas/B/PkHvw0
         HVH8Tj+W2t/0/ONC5TpwilHyYWvVR3Xfx+XrWL4hAts3kGfxiLGiYm4zW2r+q+DhCxXs
         oXSw==
X-Gm-Message-State: ALoCoQnZ5ZkHMc0YD47B7pt0x1zljE9/Zwyf05DF+tNw33hIVPvJvLacB1bKRF9lkTDO07l8d+Uj
X-Received: by 10.14.179.9 with SMTP id g9mr75250eem.93.1380784475980;
        Thu, 03 Oct 2013 00:14:35 -0700 (PDT)
Received: from localhost (out.voltaire.com. [193.47.165.251])
        by mx.google.com with ESMTPSA id bn13sm12243740eeb.11.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 03 Oct 2013 00:14:35 -0700 (PDT)
Date:   Thu, 3 Oct 2013 10:14:33 +0300
From:   Eli Cohen <eli@dev.mellanox.co.il>
To:     Alexander Gordeev <agordeev@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Michael Ellerman <michael@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy King <acking@vmware.com>, Jon Mason <jon.mason@intel.com>,
        Matt Porter <mporter@kernel.crashing.org>,
        linux-pci@vger.kernel.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux390@de.ibm.com,
        linux-s390@vger.kernel.org, x86@kernel.org,
        linux-ide@vger.kernel.org, iss_storagedev@hp.com,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        netdev@vger.kernel.org, e1000-devel@lists.sourceforge.net,
        linux-driver@qlogic.com,
        Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
        "VMware, Inc." <pv-drivers@vmware.com>, linux-scsi@vger.kernel.org
Subject: Re: [PATCH RFC 50/77] mlx5: Update MSI/MSI-X interrupts enablement
 code
Message-ID: <20131003071433.GA7299@mtldesk30>
References: <cover.1380703262.git.agordeev@redhat.com>
 <9650a7dfbcfd5f1da21f7b093665abf4b1041071.1380703263.git.agordeev@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9650a7dfbcfd5f1da21f7b093665abf4b1041071.1380703263.git.agordeev@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <eli@dev.mellanox.co.il>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38177
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eli@dev.mellanox.co.il
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

On Wed, Oct 02, 2013 at 12:49:06PM +0200, Alexander Gordeev wrote:
>  
> +	err = pci_msix_table_size(dev->pdev);
> +	if (err < 0)
> +		return err;
> +
>  	nvec = dev->caps.num_ports * num_online_cpus() + MLX5_EQ_VEC_COMP_BASE;
>  	nvec = min_t(int, nvec, num_eqs);
> +	nvec = min_t(int, nvec, err);
>  	if (nvec <= MLX5_EQ_VEC_COMP_BASE)
>  		return -ENOSPC;

Making sure we don't request more vectors then the device's is capable
of -- looks good.
>  
> @@ -131,20 +136,15 @@ static int mlx5_enable_msix(struct mlx5_core_dev *dev)
>  	for (i = 0; i < nvec; i++)
>  		table->msix_arr[i].entry = i;
>  
> -retry:
> -	table->num_comp_vectors = nvec - MLX5_EQ_VEC_COMP_BASE;
>  	err = pci_enable_msix(dev->pdev, table->msix_arr, nvec);
> -	if (err <= 0) {
> +	if (err) {
> +		kfree(table->msix_arr);
>  		return err;
> -	} else if (err > MLX5_EQ_VEC_COMP_BASE) {
> -		nvec = err;
> -		goto retry;
>  	}
>  

According to latest sources, pci_enable_msix() may still fail so why
do you want to remove this code?

> -	mlx5_core_dbg(dev, "received %d MSI vectors out of %d requested\n", err, nvec);
> -	kfree(table->msix_arr);
> +	table->num_comp_vectors = nvec - MLX5_EQ_VEC_COMP_BASE;
>  
> -	return -ENOSPC;
> +	return 0;
>  }
>  
>  static void mlx5_disable_msix(struct mlx5_core_dev *dev)
> -- 
> 1.7.7.6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe netdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
