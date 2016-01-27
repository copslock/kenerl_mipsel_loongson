Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Jan 2016 00:08:08 +0100 (CET)
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33192 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006152AbcA0XIGGgD6U (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Jan 2016 00:08:06 +0100
Received: by mail-pf0-f193.google.com with SMTP id x125so1081826pfb.0;
        Wed, 27 Jan 2016 15:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=YCbWubVVsSCkFNfXC1J0pTSpmQOjDvvGm6QI+UnwN8g=;
        b=e5bOppjDwG6AorLntTR9nF54lwlVr6Lfu5z0/NQ7Z8PSBHhmWs53HFOzFnf+UGWrVU
         6gSDpmVeFITNWqm2Kxj5ZyXOkyzTyk4oE+HHwGo+EK56touPCOBrnEKzwkwhj4rbcTwq
         /NcgLcltX7eQN2EAp7sNwu/5YyRNvKTvCAGJnB3v7hc7XoTdfzii1UjFyegysjaFh6Dm
         jdMTU9AlRz7sZkXJ3pL4aUqzM99T95E6LIKj63T5gtViM+XFVFSJAqBWlCNEI4kMlA9X
         KoWPdec/RbvSJ+5tmSgDK5k64u/H0mOZnCv+uhFtlutVCtuoDLanlY7H2GygQPA5SrA5
         lTyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=YCbWubVVsSCkFNfXC1J0pTSpmQOjDvvGm6QI+UnwN8g=;
        b=BUSewqgMgGJ1CKqQBisYVdtHEaXwwyonRLX6VuIcg/12ezrSuDHTVcV5a1CBV+atrk
         jTlwnfL0KMlS91LvzwlSPmEEsbzR9+0yFybdG74fINvOypdcwlLKx/BSkHahCBlohCYN
         6Ufy2+VN+x3uTEquRLoqweJg18n14YB/WFoBeTLwQcnrkXpqxcISMRB1ZNmRtR/URP+X
         BMH4T+RM2FYB3N+OtKx7mH5Ox2Do4l8nE1yr5AOMXnVhUmovrbEox1zHHDu4aHDOoPIR
         lxB3GTg6JMQnH0T5sBVSHpHxEVWrWS+Zc1QZ/03uIhj+PHYwDJm8cgnK16RBobaRjUxL
         I8Cw==
X-Gm-Message-State: AG10YORgn1p/BzXYiH/xMR9wUSIpnZmxQjIdRPfHcQeL4+pqyHuJlC2P48rp+mwgSzDHfw==
X-Received: by 10.98.68.199 with SMTP id m68mr46264680pfi.6.1453936073878;
        Wed, 27 Jan 2016 15:07:53 -0800 (PST)
Received: from google.com ([2620:0:1000:1301:6149:7131:eca:637b])
        by smtp.gmail.com with ESMTPSA id v75sm11363022pfa.60.2016.01.27.15.07.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 27 Jan 2016 15:07:53 -0800 (PST)
Date:   Wed, 27 Jan 2016 15:07:51 -0800
From:   Brian Norris <computersforpeace@gmail.com>
To:     Simon Arlott <simon@fire.lp0.eu>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jonas Gorski <jogo@openwrt.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH linux-next v4 11/11] mtd: bcm63xxpart: Add NAND
 partitioning support
Message-ID: <20160127230751.GB19540@google.com>
References: <566DF43B.5010400@simon.arlott.org.uk>
 <566DF6D9.2070904@simon.arlott.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <566DF6D9.2070904@simon.arlott.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <computersforpeace@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51498
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: computersforpeace@gmail.com
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

Hi,

On Sun, Dec 13, 2015 at 10:53:13PM +0000, Simon Arlott wrote:
> Add partitioning support for BCM963xx boards with NAND flash.
> 
> The following partitions are defined:
>   "boot":           CFE and nvram data
>   "rootfs":         Currently selected rootfs
>   "data":           Configuration data
>   "rootfs1_update": Container for the whole flash area used
>                     for the first rootfs to allow it to be
>                     updated
>   "rootfs2_update": Container for the whole flash area used
>                     for the second rootfs to allow it to be
>                     updated
>   "rootfs_other":   The other (not currently selected) rootfs
> 
> Example:
> [    2.157094] nand: device found, Manufacturer ID: 0xc2, Chip ID: 0xf1
> [    2.163796] nand: Macronix NAND 128MiB 3,3V 8-bit
> [    2.168648] nand: 128 MiB, SLC, erase size: 128 KiB, page size: 2048, OOB size: 64
> [    2.176588] bcm6368_nand 10000200.nand: detected 128MiB total, 128KiB blocks, 2KiB pages, 16B OOB, 8-bit, Hamming ECC
> [    2.189782] Bad block table found at page 65472, version 0x01
> [    2.196910] Bad block table found at page 65408, version 0x01
> [    2.204003] nand_read_bbt: bad block at 0x000007480000
> [    2.225220] bcm63xxpart: rootfs1: CFE image tag found at 0x20000 with version 6, board type 963168VX
> [    2.236188] bcm63xxpart: rootfs2: CFE image tag found at 0x4000000 with version 6, board type 963168VX
> [    2.246165] bcm63xxpart: CFE bootline selected latest image rootfs1 (rootfs1_seq=2, rootfs2_seq=1)
> [    2.255800] 6 bcm63xxpart partitions found on MTD device brcmnand.0
> [    2.275360] Creating 6 MTD partitions on "brcmnand.0":
> [    2.280804] 0x000000000000-0x000000020000 : "boot"
> [    2.294609] 0x000000040000-0x000001120000 : "rootfs"
> [    2.310078] 0x000007b00000-0x000007f00000 : "data"
> [    2.324052] 0x000000020000-0x000003ac0000 : "rootfs1_update"
> [    2.339190] 0x000004000000-0x000007ac0000 : "rootfs2_update"
> [    2.354290] 0x000004020000-0x000005060000 : "rootfs_other"
> 
> The nvram contains the offset and size of the boot, rootfs1, rootfs2
> and data partitions. The presence of CFE and nvram is already verified
> by reading from the boot partition which is assumed to be at offset 0
> and the NAND process aborts if the nvram read indicates that this is
> not the case.
> 
> There is bcm_tag information at the start of each rootfs that is used
> to determine which rootfs is newer and what its real offset/size is.
> 
> The CFE bootline is used to select a rootfs.
> 
> Signed-off-by: Simon Arlott <simon@fire.lp0.eu>

Have we gotten any testing besides Simon? Or any Acked-by/Reviewed-by?

> ---
> v4: Reorganised functions based on earlier new patches in the series,
>     no real logic changes other than having to check for nvram->version
>     >= 6 within the nand function instead of the nvram read function.
> 
>     Renamed "curpart" to "i" because it allows the partition layout
>     lines to be under 80 characters.
> 
> v3: Use COMPILE_TEST.
> 
>     Ensure that strings read from flash are null terminated and validate
>     bcm_tag integer values (this also moves reporting of rootfs sequence
>     numbers to later on).
> 
> v2: Use external struct bcm963xx_nvram definition for bcm963268part.
> 
>     Removed support for the nand partition number field, it's not a
>     standard Broadcom field (was added by MitraStar Technology Corp.).
> 
>  drivers/mtd/bcm63xxpart.c | 196 ++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 190 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mtd/bcm63xxpart.c b/drivers/mtd/bcm63xxpart.c
> index 26c38a1..4576b78 100644
> --- a/drivers/mtd/bcm63xxpart.c
> +++ b/drivers/mtd/bcm63xxpart.c
> @@ -16,10 +16,9 @@
>   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>   * GNU General Public License for more details.
>   *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> - *
> + * NAND flash layout derived from bcm963xx_4.12L.06B_consumer/bcmdrivers/opensource/char/board/bcm963xx/impl1/board.c,
> + *	bcm963xx_4.12L.06B_consumer/shared/opensource/include/bcm963xx/bcm_hwdefs.h:
> + * Copyright (c) 2002 Broadcom Corporation
>   */
>  
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> @@ -124,6 +123,25 @@ static int bcm63xx_read_image_tag(struct mtd_info *master, const char *name,
>  	return 1;
>  }
>  
> +static bool bcm63xx_boot_latest(struct bcm963xx_nvram *nvram)
> +{
> +	char *p;
> +
> +	STR_NULL_TERMINATE(nvram->bootline);
> +
> +	/* Find previous image parameter "p" */
> +	if (!strncmp(nvram->bootline, "p=", 2))
> +		p = nvram->bootline;
> +	else
> +		p = strstr(nvram->bootline, " p=");
> +
> +	if (p == NULL)
> +		return true;
> +
> +	p += 2;
> +	return *p != '0';
> +}
> +
>  static int bcm63xx_parse_cfe_nor_partitions(struct mtd_info *master,
>  	const struct mtd_partition **pparts, struct bcm963xx_nvram *nvram)
>  {
> @@ -283,6 +301,171 @@ out:
>  	return nrparts;
>  }
>  
> +static bool bcm63xx_parse_nand_image_tag(struct mtd_info *master,
> +	const char *name, loff_t tag_offset, u64 *rootfs_offset,
> +	u64 *rootfs_size, unsigned int *rootfs_sequence)
> +{
> +	struct bcm_tag *buf;
> +	int ret;
> +	bool rootfs_ok = false;
> +
> +	*rootfs_offset = 0;
> +	*rootfs_size = 0;
> +	*rootfs_sequence = 0;
> +
> +	buf = vmalloc(sizeof(struct bcm_tag));
> +	if (!buf)
> +		goto out;
> +
> +	ret = bcm63xx_read_image_tag(master, name, tag_offset, buf);
> +	if (!ret) {
> +		/* Get rootfs offset and size from tag data */
> +		STR_NULL_TERMINATE(buf->flash_image_start);
> +		if (kstrtou64(buf->flash_image_start, 10, rootfs_offset) ||
> +				*rootfs_offset < BCM963XX_EXTENDED_SIZE) {
> +			pr_err("%s: invalid rootfs offset: %*ph\n", name,
> +				sizeof(buf->flash_image_start),
> +				buf->flash_image_start);
> +			goto out;
> +		}
> +
> +		STR_NULL_TERMINATE(buf->root_length);
> +		if (kstrtou64(buf->root_length, 10, rootfs_size) ||
> +				rootfs_size == 0) {

Sparse and Smatch have caught errors on this line:

  drivers/mtd/bcm63xxpart.c:334:48: warning: Using plain integer as NULL pointer [sparse]
  drivers/mtd/bcm63xxpart.c:334 bcm63xx_parse_nand_image_tag() warn: variable dereferenced before check 'rootfs_size' (see line 313) [smatch]


I think you mean '*rootfs_size == 0', not 'rootfs_size == 0'.

Brian

> +			pr_err("%s: invalid rootfs size: %*ph\n", name,
> +				sizeof(buf->root_length), buf->root_length);
> +			goto out;
> +		}
> +
> +		/* Adjust for flash offset */
> +		*rootfs_offset -= BCM963XX_EXTENDED_SIZE;
> +
> +		/* Remove bcm_tag data from length */
> +		*rootfs_size -= *rootfs_offset - tag_offset;
> +
> +		/* Get image sequence number to determine which one is newer */
> +		STR_NULL_TERMINATE(buf->image_sequence);
> +		if (kstrtouint(buf->image_sequence, 10, rootfs_sequence)) {
> +			pr_err("%s: invalid rootfs sequence: %*ph\n", name,
> +				sizeof(buf->image_sequence),
> +				buf->image_sequence);
> +			goto out;
> +		}
> +
> +		rootfs_ok = true;
> +	}
> +
> +out:
> +	vfree(buf);
> +	return rootfs_ok;
> +}
> +
> +static int bcm63xx_parse_cfe_nand_partitions(struct mtd_info *master,
> +	const struct mtd_partition **pparts,
> +	struct bcm963xx_nvram *nvram)
> +{
> +	int nrparts, i;
> +	struct mtd_partition *parts;
> +	u64 rootfs1_off, rootfs1_size;
> +	unsigned int rootfs1_seq;
> +	u64 rootfs2_off, rootfs2_size;
> +	unsigned int rootfs2_seq;
> +	bool rootfs1, rootfs2;
> +	bool use_first;
> +
> +	if (nvram->version < 6) {
> +		pr_warn("nvram version %u not supported\n", nvram->version);
> +		return -EINVAL;
> +	}
> +
> +	/* We've just read the nvram from offset 0,
> +	 * so it must be located there.
> +	 */
> +	if (BCM963XX_NVRAM_NAND_PART_OFFSET(nvram, BOOT) != 0)
> +		return -EINVAL;
> +
> +	/* Get the rootfs partition locations */
> +	rootfs1 = bcm63xx_parse_nand_image_tag(master, "rootfs1",
> +		BCM963XX_NVRAM_NAND_PART_OFFSET(nvram, ROOTFS_1),
> +		&rootfs1_off, &rootfs1_size, &rootfs1_seq);
> +	rootfs2 = bcm63xx_parse_nand_image_tag(master, "rootfs2",
> +		BCM963XX_NVRAM_NAND_PART_OFFSET(nvram, ROOTFS_2),
> +		&rootfs2_off, &rootfs2_size, &rootfs2_seq);
> +
> +	/* Determine primary rootfs partition */
> +	if (rootfs1 && rootfs2) {
> +		bool use_latest = bcm63xx_boot_latest(nvram);
> +
> +		/* Compare sequence numbers */
> +		if (use_latest)
> +			use_first = rootfs1_seq > rootfs2_seq;
> +		else
> +			use_first = rootfs1_seq < rootfs2_seq;
> +
> +		pr_info("CFE bootline selected %s image rootfs%u (rootfs1_seq=%u, rootfs2_seq=%u)\n",
> +			use_latest ? "latest" : "previous",
> +			use_first ? 1 : 2,
> +			rootfs1_seq, rootfs2_seq);
> +	} else {
> +		use_first = rootfs1;
> +	}
> +
> +	/* Partitions:
> +	 * 1 boot
> +	 * 2 rootfs
> +	 * 3 data
> +	 * 4 rootfs1_update
> +	 * 5 rootfs2_update
> +	 * 6 rootfs_other
> +	 */
> +	nrparts = 6;
> +	i = 0;
> +
> +	parts = kcalloc(nrparts, sizeof(*parts), GFP_KERNEL);
> +	if (!parts)
> +		return -ENOMEM;
> +
> +	parts[i].name = "boot";
> +	parts[i].offset = BCM963XX_NVRAM_NAND_PART_OFFSET(nvram, BOOT);
> +	parts[i].size = BCM963XX_NVRAM_NAND_PART_SIZE(nvram, BOOT);
> +	i++;
> +
> +	/* Primary rootfs if either is available */
> +	if (rootfs1 || rootfs2) {
> +		parts[i].name = "rootfs";
> +		parts[i].offset = use_first ? rootfs1_off : rootfs2_off;
> +		parts[i].size = use_first ? rootfs1_size : rootfs2_size;
> +		i++;
> +	}
> +
> +	parts[i].name = "data";
> +	parts[i].offset = BCM963XX_NVRAM_NAND_PART_OFFSET(nvram, DATA);
> +	parts[i].size = BCM963XX_NVRAM_NAND_PART_SIZE(nvram, DATA);
> +	i++;
> +
> +	/* Full rootfs partitions for updates */
> +	parts[i].name = "rootfs1_update";
> +	parts[i].offset = BCM963XX_NVRAM_NAND_PART_OFFSET(nvram, ROOTFS_1);
> +	parts[i].size = BCM963XX_NVRAM_NAND_PART_SIZE(nvram, ROOTFS_1);
> +	i++;
> +
> +	parts[i].name = "rootfs2_update";
> +	parts[i].offset = BCM963XX_NVRAM_NAND_PART_OFFSET(nvram, ROOTFS_2);
> +	parts[i].size = BCM963XX_NVRAM_NAND_PART_SIZE(nvram, ROOTFS_2);
> +	i++;
> +
> +	/* Other rootfs if both are available */
> +	if (rootfs1 && rootfs2) {
> +		parts[i].name = "rootfs_other";
> +		parts[i].offset = use_first ? rootfs2_off : rootfs1_off;
> +		parts[i].size = use_first ? rootfs2_size : rootfs1_size;
> +		i++;
> +	}
> +
> +	*pparts = parts;
> +	return nrparts;
> +}
> +
>  static int bcm63xx_parse_cfe_partitions(struct mtd_info *master,
>  					const struct mtd_partition **pparts,
>  					struct mtd_part_parser_data *data)
> @@ -304,7 +487,7 @@ static int bcm63xx_parse_cfe_partitions(struct mtd_info *master,
>  	if (!mtd_type_is_nand(master))
>  		ret = bcm63xx_parse_cfe_nor_partitions(master, pparts, nvram);
>  	else
> -		ret = -EINVAL;
> +		ret = bcm63xx_parse_cfe_nand_partitions(master, pparts, nvram);
>  
>  out:
>  	vfree(nvram);
> @@ -321,5 +504,6 @@ MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Daniel Dickinson <openwrt@cshore.neomailbox.net>");
>  MODULE_AUTHOR("Florian Fainelli <florian@openwrt.org>");
>  MODULE_AUTHOR("Mike Albon <malbon@openwrt.org>");
> -MODULE_AUTHOR("Jonas Gorski <jonas.gorski@gmail.com");
> +MODULE_AUTHOR("Jonas Gorski <jonas.gorski@gmail.com>");
> +MODULE_AUTHOR("Simon Arlott");
>  MODULE_DESCRIPTION("MTD partitioning for BCM63XX CFE bootloaders");
> -- 
> 2.1.4
> 
> -- 
> Simon Arlott
