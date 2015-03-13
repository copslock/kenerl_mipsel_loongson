Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Mar 2015 18:36:39 +0100 (CET)
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:46536 "EHLO
        ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013707AbbCMRfsRJY6Z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 Mar 2015 18:35:48 +0100
Received: from localhost (localhost [127.0.0.1])
        by ducie-dc1.codethink.co.uk (Postfix) with ESMTP id 815C9460B22
        for <linux-mips@linux-mips.org>; Fri, 13 Mar 2015 17:35:43 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at ducie-dc1.codethink.co.uk
Received: from ducie-dc1.codethink.co.uk ([127.0.0.1])
        by localhost (ducie-dc1.codethink.co.uk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 66MPqmjE0ZuA; Fri, 13 Mar 2015 17:35:39 +0000 (GMT)
Received: from pm-laptop.codethink.co.uk (pm-laptop.dyn.ducie.codethink.co.uk [10.24.1.94])
        by ducie-dc1.codethink.co.uk (Postfix) with ESMTPSA id A733B460B1A;
        Fri, 13 Mar 2015 17:35:38 +0000 (GMT)
Received: from pm by pm-laptop.codethink.co.uk with local (Exim 4.84)
        (envelope-from <paul.martin@codethink.co.uk>)
        id 1YWTUo-0000Qp-EX; Fri, 13 Mar 2015 17:35:38 +0000
From:   Paul Martin <paul.martin@codethink.co.uk>
To:     linux-mips@linux-mips.org
Cc:     Paul Martin <paul.martin@codethink.co.uk>
Subject: [PATCH 3/6] MIPS: OCTEON: Turn hardware bitfields and structures inside out
Date:   Fri, 13 Mar 2015 17:34:55 +0000
Message-Id: <1426268098-1603-4-git-send-email-paul.martin@codethink.co.uk>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1426268098-1603-1-git-send-email-paul.martin@codethink.co.uk>
References: <1426268098-1603-1-git-send-email-paul.martin@codethink.co.uk>
Return-Path: <paul.martin@codethink.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46370
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.martin@codethink.co.uk
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

Although the proper way to do this for bitfields would be to use
the macro that Ralf has provided, this is a little easier to
understand as a diff.
---
 arch/mips/cavium-octeon/executive/cvmx-l2c.c |  45 +++++
 arch/mips/include/asm/octeon/cvmx-address.h  |  67 ++++++++
 arch/mips/include/asm/octeon/cvmx-bootinfo.h |  55 ++++++
 arch/mips/include/asm/octeon/cvmx-bootmem.h  |  14 ++
 arch/mips/include/asm/octeon/cvmx-fpa.h      |   7 +
 arch/mips/include/asm/octeon/cvmx-l2c.h      |   9 +
 arch/mips/include/asm/octeon/cvmx-packet.h   |   8 +
 arch/mips/include/asm/octeon/cvmx-pko.h      |  31 ++++
 arch/mips/include/asm/octeon/cvmx-pow.h      | 247 +++++++++++++++++++++++++++
 arch/mips/include/asm/octeon/cvmx-wqe.h      |  71 ++++++++
 10 files changed, 554 insertions(+)

diff --git a/arch/mips/cavium-octeon/executive/cvmx-l2c.c b/arch/mips/cavium-octeon/executive/cvmx-l2c.c
index 42e38c3..89b5273 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-l2c.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-l2c.c
@@ -519,44 +519,89 @@ int cvmx_l2c_unlock_mem_region(uint64_t start, uint64_t len)
 union __cvmx_l2c_tag {
 	uint64_t u64;
 	struct cvmx_l2c_tag_cn50xx {
+#ifdef __BIG_ENDIAN_BITFIELD
 		uint64_t reserved:40;
 		uint64_t V:1;		/* Line valid */
 		uint64_t D:1;		/* Line dirty */
 		uint64_t L:1;		/* Line locked */
 		uint64_t U:1;		/* Use, LRU eviction */
 		uint64_t addr:20;	/* Phys mem addr (33..14) */
+#else
+		uint64_t addr:20;	/* Phys mem addr (33..14) */
+		uint64_t U:1;		/* Use, LRU eviction */
+		uint64_t L:1;		/* Line locked */
+		uint64_t D:1;		/* Line dirty */
+		uint64_t V:1;		/* Line valid */
+		uint64_t reserved:40;
+#endif
 	} cn50xx;
 	struct cvmx_l2c_tag_cn30xx {
+#ifdef __BIG_ENDIAN_BITFIELD
 		uint64_t reserved:41;
 		uint64_t V:1;		/* Line valid */
 		uint64_t D:1;		/* Line dirty */
 		uint64_t L:1;		/* Line locked */
 		uint64_t U:1;		/* Use, LRU eviction */
 		uint64_t addr:19;	/* Phys mem addr (33..15) */
+#else
+		uint64_t addr:19;	/* Phys mem addr (33..15) */
+		uint64_t U:1;		/* Use, LRU eviction */
+		uint64_t L:1;		/* Line locked */
+		uint64_t D:1;		/* Line dirty */
+		uint64_t V:1;		/* Line valid */
+		uint64_t reserved:41;
+#endif
 	} cn30xx;
 	struct cvmx_l2c_tag_cn31xx {
+#ifdef __BIG_ENDIAN_BITFIELD
 		uint64_t reserved:42;
 		uint64_t V:1;		/* Line valid */
 		uint64_t D:1;		/* Line dirty */
 		uint64_t L:1;		/* Line locked */
 		uint64_t U:1;		/* Use, LRU eviction */
 		uint64_t addr:18;	/* Phys mem addr (33..16) */
+#else
+		uint64_t addr:18;	/* Phys mem addr (33..16) */
+		uint64_t U:1;		/* Use, LRU eviction */
+		uint64_t L:1;		/* Line locked */
+		uint64_t D:1;		/* Line dirty */
+		uint64_t V:1;		/* Line valid */
+		uint64_t reserved:42;
+#endif
 	} cn31xx;
 	struct cvmx_l2c_tag_cn38xx {
+#ifdef __BIG_ENDIAN_BITFIELD
 		uint64_t reserved:43;
 		uint64_t V:1;		/* Line valid */
 		uint64_t D:1;		/* Line dirty */
 		uint64_t L:1;		/* Line locked */
 		uint64_t U:1;		/* Use, LRU eviction */
 		uint64_t addr:17;	/* Phys mem addr (33..17) */
+#else
+		uint64_t addr:17;	/* Phys mem addr (33..17) */
+		uint64_t U:1;		/* Use, LRU eviction */
+		uint64_t L:1;		/* Line locked */
+		uint64_t D:1;		/* Line dirty */
+		uint64_t V:1;		/* Line valid */
+		uint64_t reserved:43;
+#endif
 	} cn38xx;
 	struct cvmx_l2c_tag_cn58xx {
+#ifdef __BIG_ENDIAN_BITFIELD
 		uint64_t reserved:44;
 		uint64_t V:1;		/* Line valid */
 		uint64_t D:1;		/* Line dirty */
 		uint64_t L:1;		/* Line locked */
 		uint64_t U:1;		/* Use, LRU eviction */
 		uint64_t addr:16;	/* Phys mem addr (33..18) */
+#else
+		uint64_t addr:16;	/* Phys mem addr (33..18) */
+		uint64_t U:1;		/* Use, LRU eviction */
+		uint64_t L:1;		/* Line locked */
+		uint64_t D:1;		/* Line dirty */
+		uint64_t V:1;		/* Line valid */
+		uint64_t reserved:44;
+#endif
 	} cn58xx;
 	struct cvmx_l2c_tag_cn58xx cn56xx;	/* 2048 sets */
 	struct cvmx_l2c_tag_cn31xx cn52xx;	/* 512 sets */
diff --git a/arch/mips/include/asm/octeon/cvmx-address.h b/arch/mips/include/asm/octeon/cvmx-address.h
index e2d874e..e4444f8 100644
--- a/arch/mips/include/asm/octeon/cvmx-address.h
+++ b/arch/mips/include/asm/octeon/cvmx-address.h
@@ -104,6 +104,7 @@ typedef enum {
 typedef union {
 
 	uint64_t u64;
+#ifdef __BIG_ENDIAN_BITFIELD
 	/* mapped or unmapped virtual address */
 	struct {
 		uint64_t R:2;
@@ -202,6 +203,72 @@ typedef union {
 		uint64_t didspace:24;
 		uint64_t unused:40;
 	} sfilldidspace;
+#else
+	struct {
+		uint64_t offset:62;
+		uint64_t R:2;
+	} sva;
+
+	struct {
+		uint64_t offset:31;
+		uint64_t zeroes:33;
+	} suseg;
+
+	struct {
+		uint64_t offset:29;
+		uint64_t sp:2;
+		uint64_t ones:33;
+	} sxkseg;
+
+	struct {
+		uint64_t pa:49;
+		uint64_t mbz:10;
+		uint64_t cca:3;
+		uint64_t R:2;
+	} sxkphys;
+
+	struct {
+		uint64_t offset:36;
+		uint64_t unaddr:4;
+		uint64_t did:8;
+		uint64_t is_io:1;
+		uint64_t mbz:15;
+	} sphys;
+
+	struct {
+		uint64_t offset:36;
+		uint64_t unaddr:4;
+		uint64_t zeroes:24;
+	} smem;
+
+	struct {
+		uint64_t offset:36;
+		uint64_t unaddr:4;
+		uint64_t did:8;
+		uint64_t is_io:1;
+		uint64_t mbz:13;
+		uint64_t mem_region:2;
+	} sio;
+
+	struct {
+		uint64_t addr:13;
+		cvmx_add_win_dec_t csrdec:2;
+		uint64_t ones:49;
+	} sscr;
+
+	struct {
+		uint64_t addr:7;
+		uint64_t type:3;
+		uint64_t unused2:3;
+		uint64_t csrdec:2;
+		uint64_t ones:49;
+	} sdma;
+
+	struct {
+		uint64_t unused:40;
+		uint64_t didspace:24;
+	} sfilldidspace;
+#endif
 
 } cvmx_addr_t;
 
diff --git a/arch/mips/include/asm/octeon/cvmx-bootinfo.h b/arch/mips/include/asm/octeon/cvmx-bootinfo.h
index 2298199..5769967 100644
--- a/arch/mips/include/asm/octeon/cvmx-bootinfo.h
+++ b/arch/mips/include/asm/octeon/cvmx-bootinfo.h
@@ -53,6 +53,7 @@
  * to 0.
  */
 struct cvmx_bootinfo {
+#ifdef __BIG_ENDIAN_BITFIELD
 	uint32_t major_version;
 	uint32_t minor_version;
 
@@ -123,6 +124,60 @@ struct cvmx_bootinfo {
 	 */
 	uint64_t fdt_addr;
 #endif
+#else                           /* __BIG_ENDIAN */
+	/*
+	 * Little-Endian: When the CPU mode is switched to
+	 * little-endian, the view of the structure has some of the
+	 * fields swapped.
+	 */
+	uint32_t minor_version;
+	uint32_t major_version;
+
+	uint64_t stack_top;
+	uint64_t heap_base;
+	uint64_t heap_end;
+	uint64_t desc_vaddr;
+
+	uint32_t stack_size;
+	uint32_t exception_base_addr;
+
+	uint32_t core_mask;
+	uint32_t flags;
+
+	uint32_t phy_mem_desc_addr;
+	uint32_t dram_size;
+
+	uint32_t eclock_hz;
+	uint32_t debugger_flags_base_addr;
+
+	uint32_t reserved0;
+	uint32_t dclock_hz;
+
+	uint8_t reserved3;
+	uint8_t reserved2;
+	uint16_t reserved1;
+	uint8_t board_rev_minor;
+	uint8_t board_rev_major;
+	uint16_t board_type;
+
+	char board_serial_number[CVMX_BOOTINFO_OCTEON_SERIAL_LEN];
+	uint8_t mac_addr_base[6];
+	uint8_t mac_addr_count;
+	uint8_t pad[5];
+
+#if (CVMX_BOOTINFO_MIN_VER >= 1)
+	uint64_t compact_flash_common_base_addr;
+	uint64_t compact_flash_attribute_base_addr;
+	uint64_t led_display_base_addr;
+#endif
+#if (CVMX_BOOTINFO_MIN_VER >= 2)
+	uint32_t config_flags;
+	uint32_t dfa_ref_clock_hz;
+#endif
+#if (CVMX_BOOTINFO_MIN_VER >= 3)
+	uint64_t fdt_addr;
+#endif
+#endif
 };
 
 #define CVMX_BOOTINFO_CFG_FLAG_PCI_HOST			(1ull << 0)
diff --git a/arch/mips/include/asm/octeon/cvmx-bootmem.h b/arch/mips/include/asm/octeon/cvmx-bootmem.h
index 352f1dc..3745625 100644
--- a/arch/mips/include/asm/octeon/cvmx-bootmem.h
+++ b/arch/mips/include/asm/octeon/cvmx-bootmem.h
@@ -95,6 +95,7 @@ struct cvmx_bootmem_named_block_desc {
  * positions for backwards compatibility.
  */
 struct cvmx_bootmem_desc {
+#if defined(__BIG_ENDIAN_BITFIELD) || defined(CVMX_BUILD_FOR_LINUX_HOST)
 	/* spinlock to control access to list */
 	uint32_t lock;
 	/* flags for indicating various conditions */
@@ -120,7 +121,20 @@ struct cvmx_bootmem_desc {
 	uint32_t named_block_name_len;
 	/* address of named memory block descriptors */
 	uint64_t named_block_array_addr;
+#else                           /* __LITTLE_ENDIAN */
+	uint32_t flags;
+	uint32_t lock;
+	uint64_t head_addr;
 
+	uint32_t minor_version;
+	uint32_t major_version;
+	uint64_t app_data_addr;
+	uint64_t app_data_size;
+
+	uint32_t named_block_name_len;
+	uint32_t named_block_num_blocks;
+	uint64_t named_block_array_addr;
+#endif
 };
 
 /**
diff --git a/arch/mips/include/asm/octeon/cvmx-fpa.h b/arch/mips/include/asm/octeon/cvmx-fpa.h
index aa26a2c..c00501d 100644
--- a/arch/mips/include/asm/octeon/cvmx-fpa.h
+++ b/arch/mips/include/asm/octeon/cvmx-fpa.h
@@ -49,6 +49,7 @@
 typedef union {
 	uint64_t u64;
 	struct {
+#ifdef __BIG_ENDIAN_BITFIELD
 		/*
 		 * the (64-bit word) location in scratchpad to write
 		 * to (if len != 0)
@@ -63,6 +64,12 @@ typedef union {
 		 * the NCB bus.
 		 */
 		uint64_t addr:40;
+#else
+		uint64_t addr:40;
+		uint64_t did:8;
+		uint64_t len:8;
+		uint64_t scraddr:8;
+#endif
 	} s;
 } cvmx_fpa_iobdma_data_t;
 
diff --git a/arch/mips/include/asm/octeon/cvmx-l2c.h b/arch/mips/include/asm/octeon/cvmx-l2c.h
index 11c0a8f..ddb4292 100644
--- a/arch/mips/include/asm/octeon/cvmx-l2c.h
+++ b/arch/mips/include/asm/octeon/cvmx-l2c.h
@@ -53,12 +53,21 @@
 union cvmx_l2c_tag {
 	uint64_t u64;
 	struct {
+#ifdef __BIG_ENDIAN_BITFIELD
 		uint64_t reserved:28;
 		uint64_t V:1;		/* Line valid */
 		uint64_t D:1;		/* Line dirty */
 		uint64_t L:1;		/* Line locked */
 		uint64_t U:1;		/* Use, LRU eviction */
 		uint64_t addr:32;	/* Phys mem (not all bits valid) */
+#else
+		uint64_t addr:32;	/* Phys mem (not all bits valid) */
+		uint64_t U:1;		/* Use, LRU eviction */
+		uint64_t L:1;		/* Line locked */
+		uint64_t D:1;		/* Line dirty */
+		uint64_t V:1;		/* Line valid */
+		uint64_t reserved:28;
+#endif
 	} s;
 };
 
diff --git a/arch/mips/include/asm/octeon/cvmx-packet.h b/arch/mips/include/asm/octeon/cvmx-packet.h
index 38aefa1..895e93d 100644
--- a/arch/mips/include/asm/octeon/cvmx-packet.h
+++ b/arch/mips/include/asm/octeon/cvmx-packet.h
@@ -39,6 +39,7 @@ union cvmx_buf_ptr {
 	void *ptr;
 	uint64_t u64;
 	struct {
+#ifdef __BIG_ENDIAN_BITFIELD
 		/* if set, invert the "free" pick of the overall
 		 * packet. HW always sets this bit to 0 on inbound
 		 * packet */
@@ -55,6 +56,13 @@ union cvmx_buf_ptr {
 		uint64_t size:16;
 		/* Pointer to the first byte of the data, NOT buffer */
 		uint64_t addr:40;
+#else
+	        uint64_t addr:40;
+	        uint64_t size:16;
+	        uint64_t pool:3;
+	        uint64_t back:4;
+	        uint64_t i:1;
+#endif
 	} s;
 };
 
diff --git a/arch/mips/include/asm/octeon/cvmx-pko.h b/arch/mips/include/asm/octeon/cvmx-pko.h
index f7d2a67..3da59bb 100644
--- a/arch/mips/include/asm/octeon/cvmx-pko.h
+++ b/arch/mips/include/asm/octeon/cvmx-pko.h
@@ -127,6 +127,7 @@ typedef struct {
 typedef union {
 	uint64_t u64;
 	struct {
+#ifdef __BIG_ENDIAN_BITFIELD
 		/* Must CVMX_IO_SEG */
 		uint64_t mem_space:2;
 		/* Must be zero */
@@ -151,6 +152,17 @@ typedef union {
 		uint64_t queue:9;
 		/* Must be zero */
 		uint64_t reserved4:3;
+#else
+	        uint64_t reserved4:3;
+	        uint64_t queue:9;
+	        uint64_t port:9;
+	        uint64_t reserved3:15;
+	        uint64_t reserved2:4;
+	        uint64_t did:8;
+	        uint64_t is_io:1;
+	        uint64_t reserved:13;
+	        uint64_t mem_space:2;
+#endif
 	} s;
 } cvmx_pko_doorbell_address_t;
 
@@ -160,6 +172,7 @@ typedef union {
 typedef union {
 	uint64_t u64;
 	struct {
+#ifdef __BIG_ENDIAN_BITFIELD
 		/*
 		 * The size of the reg1 operation - could be 8, 16,
 		 * 32, or 64 bits.
@@ -229,6 +242,24 @@ typedef union {
 		uint64_t segs:6;
 		/* Including L2, but no trailing CRC */
 		uint64_t total_bytes:16;
+#else
+	        uint64_t total_bytes:16;
+	        uint64_t segs:6;
+	        uint64_t dontfree:1;
+	        uint64_t ignore_i:1;
+	        uint64_t ipoffp1:7;
+	        uint64_t gather:1;
+	        uint64_t rsp:1;
+	        uint64_t wqp:1;
+	        uint64_t n2:1;
+	        uint64_t le:1;
+	        uint64_t reg0:11;
+	        uint64_t subone0:1;
+	        uint64_t reg1:11;
+	        uint64_t subone1:1;
+	        uint64_t size0:2;
+	        uint64_t size1:2;
+#endif
 	} s;
 } cvmx_pko_command_word0_t;
 
diff --git a/arch/mips/include/asm/octeon/cvmx-pow.h b/arch/mips/include/asm/octeon/cvmx-pow.h
index 2188e65..d5565d7 100644
--- a/arch/mips/include/asm/octeon/cvmx-pow.h
+++ b/arch/mips/include/asm/octeon/cvmx-pow.h
@@ -178,6 +178,7 @@ typedef enum {
 typedef union {
 	uint64_t u64;
 	struct {
+#ifdef __BIG_ENDIAN_BITFIELD
 		/*
 		 * Don't reschedule this entry. no_sched is used for
 		 * CVMX_POW_TAG_OP_SWTAG_DESCH and
@@ -217,6 +218,17 @@ typedef union {
 		 * CVMX_POW_TAG_OP_*_NSCHED
 		 */
 		uint64_t tag:32;
+#else
+		uint64_t tag:32;
+		uint64_t type:3;
+		uint64_t grp:4;
+		uint64_t qos:3;
+		uint64_t unused2:2;
+		cvmx_pow_tag_op_t op:4;
+		uint64_t index:13;
+		uint64_t unused:2;
+		uint64_t no_sched:1;
+#endif
 	} s;
 } cvmx_pow_tag_req_t;
 
@@ -230,6 +242,7 @@ typedef union {
      * Address for new work request loads (did<2:0> == 0)
      */
 	struct {
+#ifdef __BIG_ENDIAN_BITFIELD
 		/* Mips64 address region. Should be CVMX_IO_SEG */
 		uint64_t mem_region:2;
 		/* Must be zero */
@@ -247,12 +260,22 @@ typedef union {
 		uint64_t wait:1;
 		/* Must be zero */
 		uint64_t reserved_0_2:3;
+#else
+		uint64_t reserved_0_2:3;
+		uint64_t wait:1;
+		uint64_t reserved_4_39:36;
+		uint64_t did:8;
+		uint64_t is_io:1;
+		uint64_t reserved_49_61:13;
+		uint64_t mem_region:2;
+#endif
 	} swork;
 
     /**
      * Address for loads to get POW internal status
      */
 	struct {
+#ifdef __BIG_ENDIAN_BITFIELD
 		/* Mips64 address region. Should be CVMX_IO_SEG */
 		uint64_t mem_region:2;
 		/* Must be zero */
@@ -282,12 +305,25 @@ typedef union {
 		uint64_t get_wqp:1;
 		/* Must be zero */
 		uint64_t reserved_0_2:3;
+#else
+		uint64_t reserved_0_2:3;
+		uint64_t get_wqp:1;
+		uint64_t get_cur:1;
+		uint64_t get_rev:1;
+		uint64_t coreid:4;
+		uint64_t reserved_10_39:30;
+		uint64_t did:8;
+		uint64_t is_io:1;
+		uint64_t reserved_49_61:13;
+		uint64_t mem_region:2;
+#endif
 	} sstatus;
 
     /**
      * Address for memory loads to get POW internal state
      */
 	struct {
+#ifdef __BIG_ENDIAN_BITFIELD
 		/* Mips64 address region. Should be CVMX_IO_SEG */
 		uint64_t mem_region:2;
 		/* Must be zero */
@@ -314,12 +350,24 @@ typedef union {
 		uint64_t get_wqp:1;
 		/* Must be zero */
 		uint64_t reserved_0_2:3;
+#else
+		uint64_t reserved_0_2:3;
+		uint64_t get_wqp:1;
+		uint64_t get_des:1;
+		uint64_t index:11;
+		uint64_t reserved_16_39:24;
+		uint64_t did:8;
+		uint64_t is_io:1;
+		uint64_t reserved_49_61:13;
+		uint64_t mem_region:2;
+#endif
 	} smemload;
 
     /**
      * Address for index/pointer loads
      */
 	struct {
+#ifdef __BIG_ENDIAN_BITFIELD
 		/* Mips64 address region. Should be CVMX_IO_SEG */
 		uint64_t mem_region:2;
 		/* Must be zero */
@@ -366,6 +414,17 @@ typedef union {
 		uint64_t get_rmt:1;
 		/* Must be zero */
 		uint64_t reserved_0_2:3;
+#else
+		uint64_t reserved_0_2:3;
+		uint64_t get_rmt:1;
+		uint64_t get_des_get_tail:1;
+		uint64_t qosgrp:4;
+		uint64_t reserved_9_39:31;
+		uint64_t did:8;
+		uint64_t is_io:1;
+		uint64_t reserved_49_61:13;
+		uint64_t mem_region:2;
+#endif
 	} sindexload;
 
     /**
@@ -377,6 +436,7 @@ typedef union {
      * available.)
      */
 	struct {
+#ifdef __BIG_ENDIAN_BITFIELD
 		/* Mips64 address region. Should be CVMX_IO_SEG */
 		uint64_t mem_region:2;
 		/* Must be zero */
@@ -387,6 +447,13 @@ typedef union {
 		uint64_t did:8;
 		/* Must be zero */
 		uint64_t reserved_0_39:40;
+#else
+		uint64_t reserved_0_39:40;
+		uint64_t did:8;
+		uint64_t is_io:1;
+		uint64_t reserved_49_61:13;
+		uint64_t mem_region:2;
+#endif
 	} snull_rd;
 } cvmx_pow_load_addr_t;
 
@@ -401,6 +468,7 @@ typedef union {
      * Response to new work request loads
      */
 	struct {
+#ifdef __BIG_ENDIAN_BITFIELD
 		/*
 		 * Set when no new work queue entry was returned.  *
 		 * If there was de-scheduled work, the HW will
@@ -419,12 +487,18 @@ typedef union {
 		uint64_t reserved_40_62:23;
 		/* 36 in O1 -- the work queue pointer */
 		uint64_t addr:40;
+#else
+		uint64_t addr:40;
+		uint64_t reserved_40_62:23;
+		uint64_t no_work:1;
+#endif
 	} s_work;
 
     /**
      * Result for a POW Status Load (when get_cur==0 and get_wqp==0)
      */
 	struct {
+#ifdef __BIG_ENDIAN_BITFIELD
 		uint64_t reserved_62_63:2;
 		/* Set when there is a pending non-NULL SWTAG or
 		 * SWTAG_FULL, and the POW entry has not left the list
@@ -476,12 +550,32 @@ typedef union {
 		 *    AND pend_desched_switch) are set.
 		 */
 		uint64_t pend_tag:32;
+#else
+		uint64_t pend_tag:32;
+		uint64_t pend_type:2;
+		uint64_t reserved_34_35:2;
+		uint64_t pend_grp:4;
+		uint64_t pend_index:11;
+		uint64_t reserved_51:1;
+		uint64_t pend_nosched_clr:1;
+		uint64_t pend_null_rd:1;
+		uint64_t pend_new_work_wait:1;
+		uint64_t pend_new_work:1;
+		uint64_t pend_nosched:1;
+		uint64_t pend_desched_switch:1;
+		uint64_t pend_desched:1;
+		uint64_t pend_switch_null:1;
+		uint64_t pend_switch_full:1;
+		uint64_t pend_switch:1;
+		uint64_t reserved_62_63:2;
+#endif
 	} s_sstatus0;
 
     /**
      * Result for a POW Status Load (when get_cur==0 and get_wqp==1)
      */
 	struct {
+#ifdef __BIG_ENDIAN_BITFIELD
 		uint64_t reserved_62_63:2;
 		/*
 		 * Set when there is a pending non-NULL SWTAG or
@@ -529,6 +623,23 @@ typedef union {
 		uint64_t pend_grp:4;
 		/* This is the wqp when pend_nosched_clr is set. */
 		uint64_t pend_wqp:36;
+#else
+	        uint64_t pend_wqp:36;
+	        uint64_t pend_grp:4;
+	        uint64_t pend_index:11;
+	        uint64_t reserved_51:1;
+	        uint64_t pend_nosched_clr:1;
+	        uint64_t pend_null_rd:1;
+	        uint64_t pend_new_work_wait:1;
+	        uint64_t pend_new_work:1;
+	        uint64_t pend_nosched:1;
+	        uint64_t pend_desched_switch:1;
+	        uint64_t pend_desched:1;
+	        uint64_t pend_switch_null:1;
+	        uint64_t pend_switch_full:1;
+	        uint64_t pend_switch:1;
+	        uint64_t reserved_62_63:2;
+#endif
 	} s_sstatus1;
 
     /**
@@ -536,6 +647,7 @@ typedef union {
      * get_rev==0)
      */
 	struct {
+#ifdef __BIG_ENDIAN_BITFIELD
 		uint64_t reserved_62_63:2;
 		/*
 		 * Points to the next POW entry in the tag list when
@@ -573,12 +685,23 @@ typedef union {
 		 * SWTAG_DESCHED).
 		 */
 		uint64_t tag:32;
+#else
+	        uint64_t tag:32;
+	        uint64_t tag_type:2;
+	        uint64_t tail:1;
+	        uint64_t head:1;
+	        uint64_t grp:4;
+	        uint64_t index:11;
+	        uint64_t link_index:11;
+	        uint64_t reserved_62_63:2;
+#endif
 	} s_sstatus2;
 
     /**
      * Result for a POW Status Load (when get_cur==1, get_wqp==0, and get_rev==1)
      */
 	struct {
+#ifdef __BIG_ENDIAN_BITFIELD
 		uint64_t reserved_62_63:2;
 		/*
 		 * Points to the prior POW entry in the tag list when
@@ -617,6 +740,16 @@ typedef union {
 		 * SWTAG_DESCHED).
 		 */
 		uint64_t tag:32;
+#else
+	        uint64_t tag:32;
+	        uint64_t tag_type:2;
+	        uint64_t tail:1;
+	        uint64_t head:1;
+	        uint64_t grp:4;
+	        uint64_t index:11;
+	        uint64_t revlink_index:11;
+	        uint64_t reserved_62_63:2;
+#endif
 	} s_sstatus3;
 
     /**
@@ -624,6 +757,7 @@ typedef union {
      * get_rev==0)
      */
 	struct {
+#ifdef __BIG_ENDIAN_BITFIELD
 		uint64_t reserved_62_63:2;
 		/*
 		 * Points to the next POW entry in the tag list when
@@ -642,6 +776,13 @@ typedef union {
 		 * list entered on SWTAG_FULL).
 		 */
 		uint64_t wqp:36;
+#else
+	        uint64_t wqp:36;
+	        uint64_t grp:4;
+	        uint64_t index:11;
+	        uint64_t link_index:11;
+	        uint64_t reserved_62_63:2;
+#endif
 	} s_sstatus4;
 
     /**
@@ -649,6 +790,7 @@ typedef union {
      * get_rev==1)
      */
 	struct {
+#ifdef __BIG_ENDIAN_BITFIELD
 		uint64_t reserved_62_63:2;
 		/*
 		 * Points to the prior POW entry in the tag list when
@@ -669,12 +811,20 @@ typedef union {
 		 * list entered on SWTAG_FULL).
 		 */
 		uint64_t wqp:36;
+#else
+	        uint64_t wqp:36;
+	        uint64_t grp:4;
+	        uint64_t index:11;
+	        uint64_t revlink_index:11;
+	        uint64_t reserved_62_63:2;
+#endif
 	} s_sstatus5;
 
     /**
      * Result For POW Memory Load (get_des == 0 and get_wqp == 0)
      */
 	struct {
+#ifdef __BIG_ENDIAN_BITFIELD
 		uint64_t reserved_51_63:13;
 		/*
 		 * The next entry in the input, free, descheduled_head
@@ -695,12 +845,22 @@ typedef union {
 		uint64_t tag_type:2;
 		/* The tag of the POW entry. */
 		uint64_t tag:32;
+#else
+	        uint64_t tag:32;
+	        uint64_t tag_type:2;
+	        uint64_t tail:1;
+	        uint64_t reserved_35:1;
+	        uint64_t grp:4;
+	        uint64_t next_index:11;
+	        uint64_t reserved_51_63:13;
+#endif
 	} s_smemload0;
 
     /**
      * Result For POW Memory Load (get_des == 0 and get_wqp == 1)
      */
 	struct {
+#ifdef __BIG_ENDIAN_BITFIELD
 		uint64_t reserved_51_63:13;
 		/*
 		 * The next entry in the input, free, descheduled_head
@@ -712,12 +872,19 @@ typedef union {
 		uint64_t grp:4;
 		/* The WQP held in the POW entry. */
 		uint64_t wqp:36;
+#else
+	        uint64_t wqp:36;
+	        uint64_t grp:4;
+	        uint64_t next_index:11;
+	        uint64_t reserved_51_63:13;
+#endif
 	} s_smemload1;
 
     /**
      * Result For POW Memory Load (get_des == 1)
      */
 	struct {
+#ifdef __BIG_ENDIAN_BITFIELD
 		uint64_t reserved_51_63:13;
 		/*
 		 * The next entry in the tag list connected to the
@@ -740,12 +907,22 @@ typedef union {
 		 * is set.
 		 */
 		uint64_t pend_tag:32;
+#else
+	        uint64_t pend_tag:32;
+	        uint64_t pend_type:2;
+	        uint64_t pend_switch:1;
+	        uint64_t nosched:1;
+	        uint64_t grp:4;
+	        uint64_t fwd_index:11;
+	        uint64_t reserved_51_63:13;
+#endif
 	} s_smemload2;
 
     /**
      * Result For POW Index/Pointer Load (get_rmt == 0/get_des_get_tail == 0)
      */
 	struct {
+#ifdef __BIG_ENDIAN_BITFIELD
 		uint64_t reserved_52_63:12;
 		/*
 		 * set when there is one or more POW entries on the
@@ -791,12 +968,28 @@ typedef union {
 		 * the input Q list selected by qosgrp.
 		 */
 		uint64_t loc_tail:11;
+#else
+	        uint64_t loc_tail:11;
+	        uint64_t reserved_11:1;
+	        uint64_t loc_head:11;
+	        uint64_t reserved_23:1;
+	        uint64_t loc_one:1;
+	        uint64_t loc_val:1;
+	        uint64_t free_tail:11;
+	        uint64_t reserved_37:1;
+	        uint64_t free_head:11;
+	        uint64_t reserved_49:1;
+	        uint64_t free_one:1;
+	        uint64_t free_val:1;
+	        uint64_t reserved_52_63:12;
+#endif
 	} sindexload0;
 
     /**
      * Result For POW Index/Pointer Load (get_rmt == 0/get_des_get_tail == 1)
      */
 	struct {
+#ifdef __BIG_ENDIAN_BITFIELD
 		uint64_t reserved_52_63:12;
 		/*
 		 * set when there is one or more POW entries on the
@@ -843,12 +1036,28 @@ typedef union {
 		 * head on the descheduled list selected by qosgrp.
 		 */
 		uint64_t des_tail:11;
+#else
+	        uint64_t des_tail:11;
+	        uint64_t reserved_11:1;
+	        uint64_t des_head:11;
+	        uint64_t reserved_23:1;
+	        uint64_t des_one:1;
+	        uint64_t des_val:1;
+	        uint64_t nosched_tail:11;
+	        uint64_t reserved_37:1;
+	        uint64_t nosched_head:11;
+	        uint64_t reserved_49:1;
+	        uint64_t nosched_one:1;
+	        uint64_t nosched_val:1;
+	        uint64_t reserved_52_63:12;
+#endif
 	} sindexload1;
 
     /**
      * Result For POW Index/Pointer Load (get_rmt == 1/get_des_get_tail == 0)
      */
 	struct {
+#ifdef __BIG_ENDIAN_BITFIELD
 		uint64_t reserved_39_63:25;
 		/*
 		 * Set when this DRAM list is the current head
@@ -877,6 +1086,13 @@ typedef union {
 		 * qosgrp.
 		 */
 		uint64_t rmt_head:36;
+#else
+	        uint64_t rmt_head:36;
+	        uint64_t rmt_one:1;
+	        uint64_t rmt_val:1;
+	        uint64_t rmt_is_head:1;
+	        uint64_t reserved_39_63:25;
+#endif
 	} sindexload2;
 
     /**
@@ -884,6 +1100,7 @@ typedef union {
      * 1/get_des_get_tail == 1)
      */
 	struct {
+#ifdef __BIG_ENDIAN_BITFIELD
 		uint64_t reserved_39_63:25;
 		/*
 		 * set when this DRAM list is the current head
@@ -912,12 +1129,20 @@ typedef union {
 		 * qosgrp.
 		 */
 		uint64_t rmt_tail:36;
+#else
+	        uint64_t rmt_tail:36;
+	        uint64_t rmt_one:1;
+	        uint64_t rmt_val:1;
+	        uint64_t rmt_is_head:1;
+	        uint64_t reserved_39_63:25;
+#endif
 	} sindexload3;
 
     /**
      * Response to NULL_RD request loads
      */
 	struct {
+#ifdef __BIG_ENDIAN_BITFIELD
 		uint64_t unused:62;
 		/* of type cvmx_pow_tag_type_t. state is one of the
 		 * following:
@@ -928,6 +1153,10 @@ typedef union {
 		 * - CVMX_POW_TAG_TYPE_NULL_NULL
 		 */
 		uint64_t state:2;
+#else
+	        uint64_t state:2;
+	        uint64_t unused:62;
+#endif
 	} s_null_rd;
 
 } cvmx_pow_tag_load_resp_t;
@@ -962,6 +1191,7 @@ typedef union {
 	uint64_t u64;
 
 	struct {
+#ifdef __BIG_ENDIAN_BITFIELD
 		/* Memory region.  Should be CVMX_IO_SEG in most cases */
 		uint64_t mem_reg:2;
 		uint64_t reserved_49_61:13;	/* Must be zero */
@@ -971,6 +1201,14 @@ typedef union {
 		uint64_t reserved_36_39:4;	/* Must be zero */
 		/* Address field. addr<2:0> must be zero */
 		uint64_t addr:36;
+#else
+	        uint64_t addr:36;
+	        uint64_t reserved_36_39:4;
+	        uint64_t did:8;
+	        uint64_t is_io:1;
+	        uint64_t reserved_49_61:13;
+	        uint64_t mem_reg:2;
+#endif
 	} stag;
 } cvmx_pow_tag_store_addr_t;
 
@@ -981,6 +1219,7 @@ typedef union {
 	uint64_t u64;
 
 	struct {
+#ifdef __BIG_ENDIAN_BITFIELD
 		/*
 		 * the (64-bit word) location in scratchpad to write
 		 * to (if len != 0)
@@ -994,6 +1233,14 @@ typedef union {
 		/* if set, don't return load response until work is available */
 		uint64_t wait:1;
 		uint64_t unused2:3;
+#else
+	        uint64_t unused2:3;
+	        uint64_t wait:1;
+	        uint64_t unused:36;
+	        uint64_t did:8;
+	        uint64_t len:8;
+	        uint64_t scraddr:8;
+#endif
 	} s;
 
 } cvmx_pow_iobdma_store_t;
diff --git a/arch/mips/include/asm/octeon/cvmx-wqe.h b/arch/mips/include/asm/octeon/cvmx-wqe.h
index aa0d3d0..2d6d0c7 100644
--- a/arch/mips/include/asm/octeon/cvmx-wqe.h
+++ b/arch/mips/include/asm/octeon/cvmx-wqe.h
@@ -57,6 +57,7 @@ typedef union {
 
 	/* Use this struct if the hardware determines that the packet is IP */
 	struct {
+#ifdef __BIG_ENDIAN_BITFIELD
 		/* HW sets this to the number of buffers used by this packet */
 		uint64_t bufs:8;
 		/* HW sets to the number of L2 bytes prior to the IP */
@@ -166,13 +167,45 @@ typedef union {
 		 * the slow path */
 		/* type is cvmx_pip_err_t */
 		uint64_t err_code:8;
+#else
+	        uint64_t err_code:8;
+	        uint64_t rcv_error:1;
+	        uint64_t not_IP:1;
+	        uint64_t is_mcast:1;
+	        uint64_t is_bcast:1;
+	        uint64_t IP_exc:1;
+	        uint64_t is_frag:1;
+	        uint64_t L4_error:1;
+	        uint64_t software:1;
+	        uint64_t is_v6:1;
+	        uint64_t dec_ipsec:1;
+	        uint64_t tcp_or_udp:1;
+	        uint64_t dec_ipcomp:1;
+	        uint64_t unassigned2:4;
+	        uint64_t unassigned2a:4;
+	        uint64_t pr:4;
+	        uint64_t vlan_id:12;
+	        uint64_t vlan_cfi:1;
+	        uint64_t unassigned:1;
+	        uint64_t vlan_stacked:1;
+	        uint64_t vlan_valid:1;
+	        uint64_t ip_offset:8;
+	        uint64_t bufs:8;
+#endif
 	} s;
 
 	/* use this to get at the 16 vlan bits */
 	struct {
+#ifdef __BIG_ENDIAN_BITFIELD
 		uint64_t unused1:16;
 		uint64_t vlan:16;
 		uint64_t unused2:32;
+#else
+	        uint64_t unused2:32;
+	        uint64_t vlan:16;
+	        uint64_t unused1:16;
+
+#endif
 	} svlan;
 
 	/*
@@ -180,6 +213,7 @@ typedef union {
 	 * the packet is ip.
 	 */
 	struct {
+#ifdef __BIG_ENDIAN_BITFIELD
 		/*
 		 * HW sets this to the number of buffers used by this
 		 * packet.
@@ -296,6 +330,27 @@ typedef union {
 		 */
 		/* type is cvmx_pip_err_t (union, so can't use directly */
 		uint64_t err_code:8;
+#else
+	        uint64_t err_code:8;
+	        uint64_t rcv_error:1;
+	        uint64_t not_IP:1;
+	        uint64_t is_mcast:1;
+	        uint64_t is_bcast:1;
+	        uint64_t is_arp:1;
+	        uint64_t is_rarp:1;
+	        uint64_t unassigned3:1;
+	        uint64_t software:1;
+	        uint64_t unassigned2:4;
+	        uint64_t unassigned2a:8;
+	        uint64_t pr:4;
+	        uint64_t vlan_id:12;
+	        uint64_t vlan_cfi:1;
+	        uint64_t unassigned:1;
+	        uint64_t vlan_stacked:1;
+	        uint64_t vlan_valid:1;
+	        uint64_t unused:8;
+	        uint64_t bufs:8;
+#endif
 	} snoip;
 
 } cvmx_pip_wqe_word2;
@@ -312,6 +367,7 @@ typedef struct {
      *	HW WRITE: the following 64 bits are filled by HW when a packet arrives
      */
 
+#ifdef __BIG_ENDIAN_BITFIELD
     /**
      * raw chksum result generated by the HW
      */
@@ -327,12 +383,18 @@ typedef struct {
      * (Only 36 bits used in Octeon 1)
      */
 	uint64_t next_ptr:40;
+#else
+	uint64_t next_ptr:40;
+	uint8_t unused;
+	uint16_t hw_chksum;
+#endif
 
     /*****************************************************************
      * WORD 1
      *	HW WRITE: the following 64 bits are filled by HW when a packet arrives
      */
 
+#ifdef __BIG_ENDIAN_BITFIELD
     /**
      * HW sets to the total number of bytes in the packet
      */
@@ -359,6 +421,15 @@ typedef struct {
      * the synchronization/ordering tag
      */
 	uint64_t tag:32;
+#else
+	uint64_t tag:32;
+	uint64_t tag_type:2;
+	uint64_t zero_2:1;
+	uint64_t grp:4;
+	uint64_t qos:3;
+	uint64_t ipprt:6;
+	uint64_t len:16;
+#endif
 
     /**
      * WORD 2 HW WRITE: the following 64-bits are filled in by
-- 
2.1.4
